module 0x8ee2f296d6af14f459ccc8ff09e9c6f661bff02e164c334a37a8a39ffd84364a::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"MONKEY", b"Sea Monkey", b"Sea Monkey aka Sui Monkey. Cutest Sea Monkeys on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_1508_a8af59a9df.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

