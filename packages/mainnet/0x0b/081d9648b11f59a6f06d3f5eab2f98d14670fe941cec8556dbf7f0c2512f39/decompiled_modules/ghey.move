module 0xb081d9648b11f59a6f06d3f5eab2f98d14670fe941cec8556dbf7f0c2512f39::ghey {
    struct GHEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHEY>(arg0, 6, b"GHEY", b"We No Ghey", x"24474845592072756c653a20427579206f7220476865792e20496620796f752073656c6c2c20796f7520476865792e0a0a41726520796f7520612057652c206f722061726520796f7520612024474845593f2042656361757365205765203d204e6f20476865792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D7_DF_2_D51_0_A27_47_F5_9_E88_8_BDE_81214_A9_E_e01702d9dc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

