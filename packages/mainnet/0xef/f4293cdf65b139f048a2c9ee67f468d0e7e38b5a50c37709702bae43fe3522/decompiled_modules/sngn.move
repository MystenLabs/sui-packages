module 0xeff4293cdf65b139f048a2c9ee67f468d0e7e38b5a50c37709702bae43fe3522::sngn {
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

