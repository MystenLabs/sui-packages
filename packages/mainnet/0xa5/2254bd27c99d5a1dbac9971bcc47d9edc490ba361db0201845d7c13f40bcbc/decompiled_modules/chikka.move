module 0xa52254bd27c99d5a1dbac9971bcc47d9edc490ba361db0201845d7c13f40bcbc::chikka {
    struct CHIKKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIKKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIKKA>(arg0, 6, b"CHIkka", b"suicchini", b"big green sendoort", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_16_09_11_30_bfb01e75df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIKKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIKKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

