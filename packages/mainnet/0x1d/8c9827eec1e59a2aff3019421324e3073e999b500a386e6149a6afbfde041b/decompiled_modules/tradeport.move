module 0x1d8c9827eec1e59a2aff3019421324e3073e999b500a386e6149a6afbfde041b::tradeport {
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

    struct RoyaltyRule has drop {
        amount: u64,
    }

    public fun confirm_transfer(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: 0x2::transfer_policy::TransferRequest<Nft>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RoyaltyRule{amount: 0x2::coin::value<0x2::sui::SUI>(&arg2) * 5000 / 10000};
        0x2::transfer_policy::add_receipt<Nft, RoyaltyRule>(v0, &mut arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Nft>(arg0, arg1);
    }

    public fun create_collection(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Collection {
        Collection{
            id          : 0x2::object::new(arg1),
            version     : 1,
            mint_supply : arg0,
            minted      : 0,
            creator     : 0x2::tx_context::sender(arg1),
        }
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        0x2::kiosk::new(arg0)
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
        let (v2, v3) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(arg0.minted < arg0.mint_supply, 2);
        arg0.minted = arg0.minted + 1;
        let v0 = Nft{
            id          : 0x2::object::new(arg6),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            creator     : arg0.creator,
            mint_number : arg0.minted,
            rarity      : arg4,
        };
        0x2::transfer::public_transfer<Nft>(v0, arg5);
    }

    public fun update_mint_supply(arg0: &mut Collection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 3);
        assert!(arg0.minted <= arg1, 2);
        arg0.mint_supply = arg1;
    }

    public fun withdraw_royalty(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: &0x2::transfer_policy::TransferPolicyCap<Nft>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<Nft>(arg0, arg1, arg2, arg3), @0x1ca83b888a2fbbc05709de821fc814234d8228eb6ef6de125d211f472c7c2f97);
    }

    // decompiled from Move bytecode v6
}

