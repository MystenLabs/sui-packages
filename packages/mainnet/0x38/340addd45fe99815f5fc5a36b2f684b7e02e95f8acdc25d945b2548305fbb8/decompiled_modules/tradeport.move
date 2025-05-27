module 0x38340addd45fe99815f5fc5a36b2f684b7e02e95f8acdc25d945b2548305fbb8::tradeport {
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

    struct RoyaltyRule has drop, store {
        amount_bps: u64,
        recipient: address,
    }

    struct RoyaltyCollected has copy, drop {
        amount: u64,
        recipient: address,
        nft_id: 0x2::object::ID,
    }

    public fun confirm_transfer(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: 0x2::transfer_policy::TransferRequest<Nft>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RoyaltyRule{
            amount_bps : 5000,
            recipient  : @0x1ca83b888a2fbbc05709de821fc814234d8228eb6ef6de125d211f472c7c2f97,
        };
        let v1 = 0x2::transfer_policy::get_rule<Nft, RoyaltyRule, RoyaltyRule>(v0, arg0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2) * v1.amount_bps / 10000;
        assert!(v2 > 0, 4);
        let v3 = RoyaltyRule{
            amount_bps : 5000,
            recipient  : @0x1ca83b888a2fbbc05709de821fc814234d8228eb6ef6de125d211f472c7c2f97,
        };
        0x2::transfer_policy::add_to_balance<Nft, RoyaltyRule>(v3, arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg3));
        let v4 = RoyaltyRule{
            amount_bps : 5000,
            recipient  : @0x1ca83b888a2fbbc05709de821fc814234d8228eb6ef6de125d211f472c7c2f97,
        };
        0x2::transfer_policy::add_receipt<Nft, RoyaltyRule>(v4, &mut arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        let v5 = RoyaltyCollected{
            amount    : v2,
            recipient : v1.recipient,
            nft_id    : 0x2::transfer_policy::item<Nft>(&arg1),
        };
        0x2::event::emit<RoyaltyCollected>(v5);
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
        let v4 = v3;
        let v5 = v2;
        let v6 = RoyaltyRule{
            amount_bps : 5000,
            recipient  : @0x1ca83b888a2fbbc05709de821fc814234d8228eb6ef6de125d211f472c7c2f97,
        };
        let v7 = RoyaltyRule{
            amount_bps : 5000,
            recipient  : @0x1ca83b888a2fbbc05709de821fc814234d8228eb6ef6de125d211f472c7c2f97,
        };
        0x2::transfer_policy::add_rule<Nft, RoyaltyRule, RoyaltyRule>(v6, &mut v5, &v4, v7);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun list_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<Nft>(arg0, arg1, arg2, arg3);
    }

    public fun mint_nft(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<Nft>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(arg0.minted < arg0.mint_supply, 2);
        arg0.minted = arg0.minted + 1;
        let v0 = Nft{
            id          : 0x2::object::new(arg7),
            name        : arg2,
            description : arg3,
            image_url   : arg4,
            creator     : arg0.creator,
            mint_number : arg0.minted,
            rarity      : arg5,
        };
        let (v1, v2) = 0x2::kiosk::new(arg7);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::lock<Nft>(&mut v4, &v3, arg1, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg6);
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

