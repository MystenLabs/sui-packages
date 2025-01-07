module 0x1ebcd28e438ec06f41482bf9aa9cd7513e72e5bc0d410d9ec82702ff74f1f427::sngn {
    struct SNGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNGN>(arg0, 6, b"SNGN", b"SUINIGERIA", b"Make Nigeria great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f7cf3633_9a66_417f_97a8_7bef2939cca6_4a67159ac8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

