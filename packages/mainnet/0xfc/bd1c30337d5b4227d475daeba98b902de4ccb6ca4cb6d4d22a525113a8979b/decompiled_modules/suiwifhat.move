module 0xfcbd1c30337d5b4227d475daeba98b902de4ccb6ca4cb6d4d22a525113a8979b::suiwifhat {
    struct SUIWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIFHAT>(arg0, 6, b"Suiwifhat", b"SUIWIFHAT", b"Just an hat on the waves of SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_15_231447_49bb45ecee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

