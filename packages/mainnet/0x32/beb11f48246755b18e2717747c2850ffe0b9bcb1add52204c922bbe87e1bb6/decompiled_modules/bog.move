module 0x32beb11f48246755b18e2717747c2850ffe0b9bcb1add52204c922bbe87e1bb6::bog {
    struct BOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOG>(arg0, 6, b"BOG", b"Bober Dog", b"Bober or Dog? Bober Dog? BOBERMAN? Bober Dog Kurwa! $BOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/boberdogg_b991e67760.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

