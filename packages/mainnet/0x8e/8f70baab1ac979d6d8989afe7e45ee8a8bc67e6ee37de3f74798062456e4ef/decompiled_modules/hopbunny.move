module 0x8e8f70baab1ac979d6d8989afe7e45ee8a8bc67e6ee37de3f74798062456e4ef::hopbunny {
    struct HOPBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPBUNNY>(arg0, 6, b"HopBunny", b"HopBunnyonsui", x"484f502042554e4e59205448452046495253542042554e4e59204f4e20747572626f732e66696e616e63652026207375696e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731322420878.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPBUNNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPBUNNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

