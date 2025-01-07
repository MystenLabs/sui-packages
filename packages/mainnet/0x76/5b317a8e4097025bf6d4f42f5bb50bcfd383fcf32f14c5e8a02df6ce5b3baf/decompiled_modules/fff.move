module 0x765b317a8e4097025bf6d4f42f5bb50bcfd383fcf32f14c5e8a02df6ce5b3baf::fff {
    struct FFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFF>(arg0, 6, b"FFF", b"fff fish", x"43616e2774207377696d20776f6e27742064726f776e202853756920697320696e206d792068656164290a0a24464646202d204669736820467269656e647320466f7265766572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Pantalla_2024_10_11_a_la_s_14_58_53_800b7986e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

