module 0x86226554e93fad65524e98e5f9fae32f48c7ea21f37ad807546f7b15e654df66::blug {
    struct BLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUG>(arg0, 6, b"BLUG", b"Blue Slugcat", b"When everyones rushing, Blue Slug Cat is just like: 'I'll get there when I get there", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_145211_d7b934befe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

