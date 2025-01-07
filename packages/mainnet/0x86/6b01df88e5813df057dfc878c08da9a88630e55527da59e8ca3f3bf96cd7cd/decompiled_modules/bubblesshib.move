module 0x866b01df88e5813df057dfc878c08da9a88630e55527da59e8ca3f3bf96cd7cd::bubblesshib {
    struct BUBBLESSHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLESSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLESSHIB>(arg0, 6, b"BUBBLESSHIB", b"BUBBLES SHIBA", b"Its me, Bubble! Floating through the skies of Sui,bringing joy and looking out for every traveller. There are places youve never imagined waiting to be discovered,and theres always something exciting just ahead.Lets see where were off to next.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3780_00ded962ba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLESSHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLESSHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

