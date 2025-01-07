module 0xe7fb53301de6c7bac249ca05ef8eb37a73cd1ca9306e70a520d05a4be3093643::koharu {
    struct KOHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOHARU>(arg0, 6, b"Koharu", b"KOHARU", b"Miharu's Mom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9029_e746bb3669.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOHARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOHARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

