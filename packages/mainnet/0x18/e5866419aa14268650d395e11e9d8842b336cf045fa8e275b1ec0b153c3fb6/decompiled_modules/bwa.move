module 0x18e5866419aa14268650d395e11e9d8842b336cf045fa8e275b1ec0b153c3fb6::bwa {
    struct BWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWA>(arg0, 6, b"BWA", b"Blue Whale Agent", b"The great blue whale Agent on SUI, just enjoy like her!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Pantalla_2025_01_16_a_las_18_30_45_143a807a25.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

