module 0xbf89717db045adc72e814d9cb14b06b3abb31a04782a3525ba2ab17dd2b30bc3::chillg {
    struct CHILLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLG>(arg0, 6, b"CHILLG", b"ChillGrab", b"Altcoin makes me run Grab to earn extra income. I'm the chill Graber Guys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/c36c7009-cf6a-4db1-b197-cd7818b89385.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

