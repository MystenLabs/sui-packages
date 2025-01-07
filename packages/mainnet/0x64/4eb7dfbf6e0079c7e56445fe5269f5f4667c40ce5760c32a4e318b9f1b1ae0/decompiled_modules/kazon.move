module 0x644eb7dfbf6e0079c7e56445fe5269f5f4667c40ce5760c32a4e318b9f1b1ae0::kazon {
    struct KAZON has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAZON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAZON>(arg0, 6, b"KAZON", b"Kazon the alien", b"$KAZON are extraterrestrial creatures or life forms that do not originate from SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055527_d703ef92eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAZON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAZON>>(v1);
    }

    // decompiled from Move bytecode v6
}

