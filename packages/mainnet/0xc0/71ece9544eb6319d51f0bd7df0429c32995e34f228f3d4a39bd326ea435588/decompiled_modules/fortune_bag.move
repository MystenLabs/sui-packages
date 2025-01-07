module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::fortune_bag {
    struct Mint has copy, drop {
        id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    struct Claim has copy, drop {
        id: 0x2::object::ID,
    }

    struct FORTUNE_BAG has drop {
        dummy_field: bool,
    }

    struct FortuneBag has store, key {
        id: 0x2::object::UID,
        state: u8,
    }

    fun init(arg0: FORTUNE_BAG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BuckYou Fortune Bag"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Thanks for helping share abundance and prosperity this Chinese New Year! One Fortune Bag entitles you to 0.01% of the Final Prize Pool in the BuckYou CNY Event at https://cny.buckyou.io/."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmYvx5XTQ4KgFbskbKbQDRWZ1pq371pHex8QFHwQaU6dJw/{state}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cny.buckyou.io/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BuckYou"));
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = 0x2::package::claim<FORTUNE_BAG>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<FortuneBag>(&v5, v0, v2, arg1);
        0x2::display::update_version<FortuneBag>(&mut v6);
        let (v7, v8) = 0x2::transfer_policy::new<FortuneBag>(&v5, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<FortuneBag>>(v6, v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<FortuneBag>>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<FortuneBag>>(v8, v4);
    }

    public fun is_claimable(arg0: &FortuneBag) : bool {
        arg0.state == 1
    }

    public fun mint(arg0: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::contributor::ContributorCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<FortuneBag>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg4) {
            let v1 = FortuneBag{
                id    : 0x2::object::new(arg5),
                state : 1,
            };
            let v2 = Mint{
                id       : 0x2::object::id<FortuneBag>(&v1),
                cap_id   : 0x2::object::id<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::contributor::ContributorCap>(arg0),
                kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            };
            0x2::event::emit<Mint>(v2);
            0x2::kiosk::lock<FortuneBag>(arg1, arg2, arg3, v1);
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::contributor::deduct_shares(arg0);
            v0 = v0 + 1;
        };
    }

    public(friend) fun set_claimed(arg0: &mut FortuneBag) {
        arg0.state = 0;
        let v0 = Claim{id: 0x2::object::id<FortuneBag>(arg0)};
        0x2::event::emit<Claim>(v0);
    }

    // decompiled from Move bytecode v6
}

