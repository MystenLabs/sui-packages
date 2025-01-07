module 0xb21c0c5c628f493b66a6119372864ac48187c15b33084a3db2a9260fae036117::beautiful {
    struct BEAUTIFUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAUTIFUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAUTIFUL>(arg0, 6, b"Beautiful", b"sui jing jing", x"537569206a696e67206a696e67206d65616e7320766572792062656175746966756c20696e20546861690a0a68747470733a2f2f742e6d652f5375694a696e674a696e6742656175746966756c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x12970_E6868f88f6557_B76120662c1_B3_E50_A646bf_c8139d19ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAUTIFUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAUTIFUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

