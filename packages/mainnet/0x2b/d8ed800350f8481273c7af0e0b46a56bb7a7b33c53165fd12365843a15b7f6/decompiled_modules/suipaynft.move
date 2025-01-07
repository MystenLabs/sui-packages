module 0x2bd8ed800350f8481273c7af0e0b46a56bb7a7b33c53165fd12365843a15b7f6::suipaynft {
    struct CreatorCap has key {
        id: 0x2::object::UID,
    }

    struct ContractInfo has key {
        id: 0x2::object::UID,
        owner_address: address,
        required_payment: u64,
        count: u16,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        traits: vector<0x1::string::String>,
        name: 0x1::string::String,
        nr: 0x1::string::String,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        discountPct: u8,
        trait: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        id: 0x2::object::ID,
        minted_by: address,
    }

    struct SUIPAYNFT has drop {
        dummy_field: bool,
    }

    public entry fun add_discount(arg0: &CreatorCap, arg1: address, arg2: 0x1::string::String, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Whitelist{
            id          : 0x2::object::new(arg4),
            discountPct : arg3,
            trait       : arg2,
        };
        0x2::transfer::public_transfer<Whitelist>(v0, arg1);
    }

    public entry fun add_field(arg0: &CreatorCap, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::add<NFT>(arg1, arg2, arg3);
    }

    public entry fun add_trait(arg0: &CreatorCap, arg1: &mut NFT, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<0x1::string::String>(&mut arg1.traits, arg2);
    }

    public fun contract_info(arg0: &ContractInfo) : &ContractInfo {
        arg0
    }

    fun convert(arg0: u16) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = b"";
        0x1::vector::push_back<u8>(&mut v1, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v1, ((arg0 & 255) as u8));
        0x1::string::append_utf8(&mut v0, 0x2::hex::encode(v1));
        v0
    }

    public entry fun destroy(arg0: NFT) {
        let NFT {
            id     : v0,
            traits : _,
            name   : _,
            nr     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun edit_field(arg0: &CreatorCap, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::edit<NFT>(arg1, arg2, arg3);
    }

    fun init(arg0: SUIPAYNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CreatorCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://axelra.net/nft/{nr}.html"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://axelra.net/nft/{nr}.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Test Sui Pay NFT3"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://axelra.net/nft"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Sui Pay Test Team"));
        let v5 = 0x2::package::claim<SUIPAYNFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = ContractInfo{
            id               : 0x2::object::new(arg1),
            owner_address    : 0x2::tx_context::sender(arg1),
            required_payment : 100000000000,
            count            : 0,
        };
        0x2::transfer::share_object<ContractInfo>(v7);
    }

    public entry fun mint(arg0: &mut ContractInfo, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.required_payment;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 0);
        let v1 = 0x2::tx_context::sender(arg3);
        mintInternal(0x1::vector::empty<0x1::string::String>(), arg0, v0, arg1, arg2, v1, arg3);
    }

    public entry fun mintDiscount(arg0: &mut ContractInfo, arg1: &Whitelist, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.required_payment * (arg1.discountPct as u64) / 100;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0, 0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg1.trait);
        let v2 = 0x2::tx_context::sender(arg4);
        mintInternal(v1, arg0, v0, arg2, arg3, v2, arg4);
    }

    fun mintInternal(arg0: vector<0x1::string::String>, arg1: &mut ContractInfo, arg2: u64, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.count < 1234, 1);
        arg1.count = arg1.count + 1;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg4, arg2, arg1.owner_address, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg5);
        let v0 = NFT{
            id     : 0x2::object::new(arg6),
            traits : arg0,
            name   : arg3,
            nr     : convert(arg1.count),
        };
        let v1 = NFTMinted{
            id        : 0x2::object::id<NFT>(&v0),
            minted_by : arg5,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<NFT>(v0, arg5);
    }

    public fun pay_nft(arg0: &NFT) : &NFT {
        arg0
    }

    public entry fun remove_field(arg0: &CreatorCap, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String) {
        0x2::display::remove<NFT>(arg1, arg2);
    }

    public entry fun set_owner_address(arg0: &CreatorCap, arg1: &mut ContractInfo, arg2: address) {
        arg1.owner_address = arg2;
    }

    public entry fun set_required_payment(arg0: &CreatorCap, arg1: &mut ContractInfo, arg2: u64) {
        arg1.required_payment = arg2;
    }

    public fun whitelist(arg0: &Whitelist) : &Whitelist {
        arg0
    }

    // decompiled from Move bytecode v6
}

