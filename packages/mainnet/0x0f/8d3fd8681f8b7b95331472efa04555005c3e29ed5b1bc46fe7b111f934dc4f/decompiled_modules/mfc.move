module 0xf8d3fd8681f8b7b95331472efa04555005c3e29ed5b1bc46fe7b111f934dc4f::mfc {
    struct MFC has drop {
        dummy_field: bool,
    }

    struct WrappedDenyCap has store, key {
        id: 0x2::object::UID,
        denyCap: 0x2::coin::DenyCapV2<MFC>,
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

