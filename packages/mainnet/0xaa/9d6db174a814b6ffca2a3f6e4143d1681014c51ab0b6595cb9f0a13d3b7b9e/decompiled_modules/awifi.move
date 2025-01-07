module 0xaa9d6db174a814b6ffca2a3f6e4143d1681014c51ab0b6595cb9f0a13d3b7b9e::awifi {
    struct AWIFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWIFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWIFI>(arg0, 6, b"AWIFI", b"Achi Wif Iroke", b"Achi Wif Iroke no Achi Wif Hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/favicon_ac740b5b41.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWIFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AWIFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

