module 0xc5825377504ba985e46e0316926984894ab86800328edbdab5478c148ec68a4b::asd11 {
    struct ASD11 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASD11, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASD11>(arg0, 9, b"asd11", b"asd11", b"asdasd1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASD11>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD11>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

