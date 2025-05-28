module 0xa8afe6e7ac213c76fe9eca060b45158f965b76e2812444f5b51710ff4d5f14cb::tradeport {
    struct TRADEPORT has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        mint_number: u64,
        rarity: 0x1::string::String,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        version: u64,
        mint_supply: u64,
        minted: u64,
        creator: address,
    }

    public fun add_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: &0x2::transfer_policy::TransferPolicyCap<Nft>, arg2: u16, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xa8afe6e7ac213c76fe9eca060b45158f965b76e2812444f5b51710ff4d5f14cb::royalty_rule::add<Nft>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun complete_transfer(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: 0x2::transfer_policy::TransferRequest<Nft>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64, 0x2::object::ID) {
        0xa8afe6e7ac213c76fe9eca060b45158f965b76e2812444f5b51710ff4d5f14cb::royalty_rule::pay<Nft>(arg0, &mut arg1, arg2, arg3);
        0x2::transfer_policy::confirm_request<Nft>(arg0, arg1)
    }

    public fun create_collection(arg0: &0x2::package::Publisher, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (Collection, 0x2::transfer_policy::TransferPolicyCap<Nft>) {
        let v0 = Collection{
            id          : 0x2::object::new(arg2),
            version     : 1,
            mint_supply : arg1,
            minted      : 0,
            creator     : 0x2::tx_context::sender(arg2),
        };
        let (v1, v2) = 0x2::transfer_policy::new<Nft>(arg0, arg2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v1);
        (v0, v2)
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        0x2::kiosk::new(arg0)
    }

    public fun estimate_royalty_fee(arg0: &0x2::transfer_policy::TransferPolicy<Nft>, arg1: u64) : u64 {
        0xa8afe6e7ac213c76fe9eca060b45158f965b76e2812444f5b51710ff4d5f14cb::royalty_rule::fee_amount<Nft>(arg0, arg1)
    }

    public fun get_minted_count(arg0: &Collection) : u64 {
        arg0.minted
    }

    fun init(arg0: TRADEPORT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TRADEPORT>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{mint_number}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::update_version<Nft>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<Nft>>(v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: &mut Collection, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(arg0.minted < arg0.mint_supply, 2);
        assert!(arg0.creator == 0x2::tx_context::sender(arg7), 3);
        arg0.minted = arg0.minted + 1;
        let v0 = Nft{
            id          : 0x2::object::new(arg7),
            name        : arg3,
            description : arg4,
            image_url   : arg5,
            creator     : arg0.creator,
            mint_number : arg0.minted,
            rarity      : arg6,
        };
        0x2::kiosk::place<Nft>(arg1, arg2, v0);
    }

    public fun update_mint_supply(arg0: &mut Collection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 3);
        assert!(arg0.minted <= arg1, 2);
        arg0.mint_supply = arg1;
    }

    public fun withdraw_royalties(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: &0x2::transfer_policy::TransferPolicyCap<Nft>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::transfer_policy::withdraw<Nft>(arg0, arg1, 0x1::option::none<u64>(), arg2)
    }

    // decompiled from Move bytecode v6
}

