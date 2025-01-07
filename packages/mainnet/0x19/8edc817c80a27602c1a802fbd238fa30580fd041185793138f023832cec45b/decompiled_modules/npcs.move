module 0x198edc817c80a27602c1a802fbd238fa30580fd041185793138f023832cec45b::npcs {
    struct NPCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPCS>(arg0, 6, b"NPCS", b"OSIRIS NPCS", x"536f6c616e61206d656d6520636f696e20696e766573746f722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/72vy_V6_UL_400x400_eec1bfedc8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NPCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

