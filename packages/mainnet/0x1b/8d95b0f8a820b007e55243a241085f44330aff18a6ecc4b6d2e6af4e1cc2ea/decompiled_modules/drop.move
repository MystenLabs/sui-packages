module 0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::drop {
    struct DROP has drop {
        dummy_field: bool,
    }

    struct Drop has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        price: u64,
        max_supply: u64,
        minted: u64,
        end_ms: u64,
        royalty_bps: u64,
    }

    struct DropNFT has store, key {
        id: 0x2::object::UID,
        drop_id: 0x2::object::ID,
        number: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct DropCreated has copy, drop {
        drop_id: 0x2::object::ID,
        creator: address,
        price: u64,
        max_supply: u64,
    }

    struct MintEvent has copy, drop {
        drop_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        number: u64,
        minter: address,
        creator: address,
        referrer: address,
        price: u64,
        creator_amount: u64,
        referrer_amount: u64,
        fee_amount: u64,
    }

    public fun close(arg0: &mut Drop, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 8);
        arg0.max_supply = arg0.minted;
    }

    public fun create_drop(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg4 > 0, 6);
        assert!(arg6 <= 2500, 5);
        let v0 = Drop{
            id          : 0x2::object::new(arg7),
            creator     : 0x2::tx_context::sender(arg7),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            price       : arg3,
            max_supply  : arg4,
            minted      : 0,
            end_ms      : arg5,
            royalty_bps : arg6,
        };
        let v1 = 0x2::object::id<Drop>(&v0);
        let v2 = DropCreated{
            drop_id    : v1,
            creator    : v0.creator,
            price      : arg3,
            max_supply : arg4,
        };
        0x2::event::emit<DropCreated>(v2);
        0x2::transfer::share_object<Drop>(v0);
        v1
    }

    fun init(arg0: DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DROP>(arg0, arg1);
        let v1 = 0x2::display::new<DropNFT>(&v0, arg1);
        0x2::display::add<DropNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{number}"));
        0x2::display::add<DropNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<DropNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<DropNFT>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://tapdrop.tapdroponsui.workers.dev/m/{drop_id}"));
        0x2::display::add<DropNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://tapdrop.tapdroponsui.workers.dev"));
        0x2::display::add<DropNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"TapDrop"));
        0x2::display::update_version<DropNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<DropNFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<DropNFT>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<DropNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DropNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun max_supply(arg0: &Drop) : u64 {
        arg0.max_supply
    }

    public fun mint(arg0: &0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip::Config, arg1: &mut Drop, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : DropNFT {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg1.price, 1);
        assert!(arg1.minted < arg1.max_supply, 2);
        assert!(arg1.end_ms == 0 || 0x2::clock::timestamp_ms(arg5) < arg1.end_ms, 3);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = arg3 != @0x0 && arg4 > 0;
        assert!(!v1 || arg3 != v0 && arg3 != arg1.creator, 7);
        let (v2, v3, v4) = quote_with(arg0, arg1.price, v1, arg4);
        if (arg1.price == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        } else {
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4, arg6), 0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip::fee_recipient(arg0));
            };
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg6), arg3);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1.creator);
        };
        arg1.minted = arg1.minted + 1;
        let v5 = DropNFT{
            id          : 0x2::object::new(arg6),
            drop_id     : 0x2::object::id<Drop>(arg1),
            number      : arg1.minted,
            name        : arg1.name,
            description : arg1.description,
            image_url   : arg1.image_url,
        };
        let v6 = if (v1) {
            arg3
        } else {
            @0x0
        };
        let v7 = MintEvent{
            drop_id         : 0x2::object::id<Drop>(arg1),
            nft_id          : 0x2::object::id<DropNFT>(&v5),
            number          : arg1.minted,
            minter          : v0,
            creator         : arg1.creator,
            referrer        : v6,
            price           : arg1.price,
            creator_amount  : v2,
            referrer_amount : v3,
            fee_amount      : v4,
        };
        0x2::event::emit<MintEvent>(v7);
        v5
    }

    entry fun mint_to_sender(arg0: &0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip::Config, arg1: &mut Drop, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<DropNFT>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun minted(arg0: &Drop) : u64 {
        arg0.minted
    }

    public fun nft_number(arg0: &DropNFT) : u64 {
        arg0.number
    }

    public fun price(arg0: &Drop) : u64 {
        arg0.price
    }

    public fun quote(arg0: u64, arg1: bool, arg2: u64) : (u64, u64, u64) {
        quote_bps(arg0, arg1, arg2, 250)
    }

    fun quote_bps(arg0: u64, arg1: bool, arg2: u64, arg3: u64) : (u64, u64, u64) {
        assert!(arg2 <= 2000, 4);
        let v0 = (((arg0 as u128) * (arg3 as u128) / (10000 as u128)) as u64);
        let v1 = if (arg1) {
            (((arg0 as u128) * (arg2 as u128) / (10000 as u128)) as u64)
        } else {
            0
        };
        (arg0 - v0 - v1, v1, v0)
    }

    public fun quote_with(arg0: &0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip::Config, arg1: u64, arg2: bool, arg3: u64) : (u64, u64, u64) {
        quote_bps(arg1, arg2, arg3, 0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip::mint_fee_bps(arg0))
    }

    // decompiled from Move bytecode v7
}

