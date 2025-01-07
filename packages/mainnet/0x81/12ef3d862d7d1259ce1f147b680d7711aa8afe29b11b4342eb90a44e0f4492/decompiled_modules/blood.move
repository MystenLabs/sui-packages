module 0x8112ef3d862d7d1259ce1f147b680d7711aa8afe29b11b4342eb90a44e0f4492::blood {
    struct BLOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOD>(arg0, 6, b"BLOOD", b"Blood Trump", x"54686520656c656374696f6e20697320636f6d696e672e2e2e2e205472756d70207468726f77696e20757020686973207365742c20756c74696d617465206d656d650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blood_trump_d65b8ca87a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

