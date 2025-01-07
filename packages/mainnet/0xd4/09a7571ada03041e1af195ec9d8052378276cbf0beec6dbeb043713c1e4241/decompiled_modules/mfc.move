module 0xd409a7571ada03041e1af195ec9d8052378276cbf0beec6dbeb043713c1e4241::mfc {
    struct MFC has drop {
        dummy_field: bool,
    }

    struct WrappedDenyCap has store, key {
        id: 0x2::object::UID,
        denyCap: 0x2::coin::DenyCapV2<MFC>,
    }

    public fun change_v0(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut WrappedDenyCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MFC>(arg0, &mut arg1.denyCap, arg2, arg3);
    }

    public fun change_v1(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut WrappedDenyCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MFC>(arg0, &mut arg1.denyCap, arg2, arg3);
    }

    fun init(arg0: MFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MFC>(arg0, 6, b"MFC", b"Modman Foundation Coin", b"Modman Foundation Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1722038581038-66f7f9813c33032b86bfc7f1904c22b2.png"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MFC>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFC>>(v0, 0x2::tx_context::sender(arg1));
        let v3 = WrappedDenyCap{
            id      : 0x2::object::new(arg1),
            denyCap : v1,
        };
        0x2::transfer::public_transfer<WrappedDenyCap>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

