module 0x2be1ce8d7c5d4471cb8de9f826a104032efa1ff4f85011262fd642b9ade83a0f::bosuiiu {
    struct BOSUIIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSUIIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSUIIU>(arg0, 6, b"BOSUIIU", b"BOOKS OFSUIS", b"Chapter 12345: The Genesis of Gains \"Thou shalt ape into projects without hesitation, for fortune favors the degen.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rectangulo_1_370d70e160_3b3628384a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSUIIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSUIIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

