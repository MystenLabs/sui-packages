module 0xb8922797f463602405c0fb2d6920e0974e422696dbeada96809d8948c2e3a9fb::pepeghost {
    struct PEPEGHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEGHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEGHOST>(arg0, 6, b"PEPEGHOST", b"PepeGhost on sui", b"$PEPEGHOST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e1_S_Bux_We_400x400_342234a3ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEGHOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEGHOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

