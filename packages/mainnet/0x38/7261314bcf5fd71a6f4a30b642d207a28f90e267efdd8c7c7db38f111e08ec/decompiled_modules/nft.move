module 0x387261314bcf5fd71a6f4a30b642d207a28f90e267efdd8c7c7db38f111e08ec::nft {
    struct Collection has store, key {
        id: 0x2::object::UID,
        royalty_recipient: address,
        total_supply: u64,
        publisher: 0x2::package::Publisher,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        rarity: 0x1::string::String,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct RoyaltyRule has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig has drop, store {
        amount_bp: u16,
    }

    struct PersonalKioskCap has store, key {
        id: 0x2::object::UID,
        cap: 0x1::option::Option<0x2::kiosk::KioskOwnerCap>,
    }

    struct NewPersonalKiosk has copy, drop {
        kiosk_id: 0x2::object::ID,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
    }

    struct OwnerMarker has copy, drop, store {
        dummy_field: bool,
    }

    fun add_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: &0x2::transfer_policy::TransferPolicyCap<Nft>) {
        let v0 = RoyaltyRule{dummy_field: false};
        let v1 = RoyaltyConfig{amount_bp: 2000};
        0x2::transfer_policy::add_rule<Nft, RoyaltyRule, RoyaltyConfig>(v0, arg0, arg1, v1);
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = create_personal_kiosk(v3, v1, arg0);
        0x2::transfer::public_transfer<PersonalKioskCap>(v4, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    fun create_personal_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) : PersonalKioskCap {
        assert!(0x2::kiosk::has_access(arg0, &arg1), 3);
        0x2::kiosk::set_owner_custom(arg0, &arg1, 0x2::tx_context::sender(arg2));
        let v0 = OwnerMarker{dummy_field: false};
        0x2::dynamic_field::add<OwnerMarker, address>(0x2::kiosk::uid_mut_as_owner(arg0, &arg1), v0, 0x2::tx_context::sender(arg2));
        let v1 = NewPersonalKiosk{kiosk_id: 0x2::object::id<0x2::kiosk::Kiosk>(arg0)};
        0x2::event::emit<NewPersonalKiosk>(v1);
        PersonalKioskCap{
            id  : 0x2::object::new(arg2),
            cap : 0x1::option::some<0x2::kiosk::KioskOwnerCap>(arg1),
        }
    }

    public entry fun create_policy(arg0: &mut Collection, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<Nft>(&arg0.publisher, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        add_royalty_rule(v4, &v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v2, arg0.royalty_recipient);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v3);
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Collection{
            id                : 0x2::object::new(arg1),
            royalty_recipient : v0,
            total_supply      : 0,
            publisher         : 0x2::package::claim<NFT>(arg0, arg1),
        };
        let v2 = 0x2::display::new<Nft>(&v1.publisher, arg1);
        0x2::display::add<Nft>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Nft>(&mut v2, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::update_version<Nft>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v2, v0);
        0x2::transfer::public_share_object<Collection>(v1);
    }

    public fun is_personal(arg0: &0x2::kiosk::Kiosk) : bool {
        let v0 = OwnerMarker{dummy_field: false};
        0x2::dynamic_field::exists_<OwnerMarker>(0x2::kiosk::uid(arg0), v0)
    }

    public entry fun mint_and_place(arg0: &mut Collection, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &PersonalKioskCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Nft{
            id        : 0x2::object::new(arg6),
            name      : 0x1::string::utf8(arg1),
            image_url : 0x1::string::utf8(arg2),
            rarity    : 0x1::string::utf8(arg3),
        };
        arg0.total_supply = arg0.total_supply + 1;
        let v1 = MintEvent{
            nft_id    : 0x2::object::id<Nft>(&v0),
            recipient : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::kiosk::place<Nft>(arg4, 0x1::option::borrow<0x2::kiosk::KioskOwnerCap>(&arg5.cap), v0);
    }

    public fun pay_royalty(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: &mut 0x2::transfer_policy::TransferRequest<Nft>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RoyaltyRule{dummy_field: false};
        let v1 = (((0x2::transfer_policy::paid<Nft>(arg1) as u128) * (0x2::transfer_policy::get_rule<Nft, RoyaltyRule, RoyaltyConfig>(v0, arg0).amount_bp as u128) / 10000) as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v1, 0);
        let v2 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<Nft, RoyaltyRule>(v2, arg0, 0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg3));
        let v3 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<Nft, RoyaltyRule>(v3, arg1);
    }

    public entry fun withdraw_royalties(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: &0x2::transfer_policy::TransferPolicyCap<Nft>, arg2: &Collection, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer_policy::withdraw<Nft>(arg0, arg1, 0x1::option::none<u64>(), arg3);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg2.royalty_recipient);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

