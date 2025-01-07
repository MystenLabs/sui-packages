module 0xbdbe289a009d1516229b864a31b2ca54efea818e7cdafa43c7032175751abb46::suimar {
    struct SUIMAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAR>(arg0, 6, b"SUIMAR", b"SUIMASTER", b"Meet the greatness of Aquaman. SUIMASTER The true king of SUI Kingdom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x7a1495d9b7debde00cb5b1d0b2d5484234d93e04a5290524274be11842825b99_aqua_aqua_b10cbd1763_1_495d82488a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

