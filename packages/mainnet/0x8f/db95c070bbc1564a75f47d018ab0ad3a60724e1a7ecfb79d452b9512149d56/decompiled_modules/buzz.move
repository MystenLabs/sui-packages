module 0x8fdb95c070bbc1564a75f47d018ab0ad3a60724e1a7ecfb79d452b9512149d56::buzz {
    struct BUZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUZZ>(arg0, 6, b"BUZZ", b"Buzzarius", b"Buzzarius is a Roman-inspired coin featuring a cute bee adorned with a laurel wreath and holding a small scepter. The bee combines a regal appearance with playful charm. 'Buzzarius'a blend of 'buzz' and 'Denarius'adds a fun twist while maintaining the elegance of a classic Roman coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Buzzarius_the_Bee_Emperor_49f362eede.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

