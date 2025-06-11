module 0xd870e996993b3f4e41653204c5d6c458b239395e45539bde675bae5c3375d90a::kiosk_nft {
    struct KIOSK_NFT has drop {
        dummy_field: bool,
    }

    struct KlausMueller has drop {
        dummy_field: bool,
    }

    struct HaydenMichael has drop {
        dummy_field: bool,
    }

    struct Zack has drop {
        dummy_field: bool,
    }

    struct Janky has drop {
        dummy_field: bool,
    }

    struct Coolman has drop {
        dummy_field: bool,
    }

    struct Spesh has drop {
        dummy_field: bool,
    }

    struct Portrait<phantom T0> has store, key {
        id: 0x2::object::UID,
        mint_number: u64,
    }

    public fun get_mint_number<T0>(arg0: &Portrait<T0>) : u64 {
        arg0.mint_number
    }

    public fun get_royalty_fee_amount(arg0: &0x2::transfer_policy::TransferPolicy<Portrait<KlausMueller>>, arg1: u64) : u64 {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<Portrait<KlausMueller>>(arg0, arg1)
    }

    fun init(arg0: KIOSK_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<KIOSK_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<Portrait<KlausMueller>>(&v0, arg1);
        0x2::display::add<Portrait<KlausMueller>>(&mut v1, 0x1::string::utf8(b"mint_number"), 0x1::string::utf8(b"{mint_number}"));
        0x2::display::update_version<Portrait<KlausMueller>>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<Portrait<KlausMueller>>>(v1);
        let (v2, v3) = 0x2::transfer_policy::new<Portrait<KlausMueller>>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<Portrait<KlausMueller>>(&mut v5, &v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Portrait<KlausMueller>>(&mut v5, &v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Portrait<KlausMueller>>(&mut v5, &v4, 1000, 1000);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Portrait<KlausMueller>>>(v5);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Portrait<KlausMueller>>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_portrait<T0>(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Portrait<T0>{
            id          : 0x2::object::new(arg2),
            mint_number : arg0,
        };
        0x2::transfer::public_transfer<Portrait<T0>>(v0, arg1);
    }

    public fun pay_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<Portrait<KlausMueller>>, arg1: &mut 0x2::transfer_policy::TransferRequest<Portrait<KlausMueller>>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<Portrait<KlausMueller>>(arg0, arg1, arg2);
    }

    public fun prove_kiosk_lock_rule(arg0: &0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<Portrait<KlausMueller>>, arg2: &mut 0x2::transfer_policy::TransferRequest<Portrait<KlausMueller>>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<Portrait<KlausMueller>>(arg2, arg0);
    }

    public fun prove_personal_kiosk_rule(arg0: &0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<Portrait<KlausMueller>>, arg2: &mut 0x2::transfer_policy::TransferRequest<Portrait<KlausMueller>>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<Portrait<KlausMueller>>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

