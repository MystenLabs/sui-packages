module 0x86785365f106e91f491cb899307f627dc8fdc515055931b7d88fd4efd7e401a6::ded {
    struct DED has drop {
        dummy_field: bool,
    }

    fun init(arg0: DED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DED>(arg0, 6, b"DED", b"DED CAT", b"he ran out of lives", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_09_26_093915_f99c8d3021.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DED>>(v1);
    }

    // decompiled from Move bytecode v6
}

