module 0x1e6212f2f07c63f1efb8e1fb032a67b8e38c28d5023d9d2f7f1600ec73a9faa0::asuike {
    struct ASUIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUIKE>(arg0, 6, b"ASUIKE", b"Asuike", b"In feudal Japan, there lived a black shiba inu named Asuike, known as the \"Samurai of the Shadows.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tmo7j_PHT_400x400_d965926bee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

