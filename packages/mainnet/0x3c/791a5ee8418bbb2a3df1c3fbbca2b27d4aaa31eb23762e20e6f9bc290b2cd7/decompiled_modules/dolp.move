module 0x3c791a5ee8418bbb2a3df1c3fbbca2b27d4aaa31eb23762e20e6f9bc290b2cd7::dolp {
    struct DOLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLP>(arg0, 6, b"DOLP", b"DOLPSUI", x"24444f4c50202d20544845204f4e4c5920444f4c5048494e20530a4f4e205448452053554920424c4f434b434841494e0a0a446f6c70206973207468652062657374206171756174696320616e696d616c206578697374696e6720696e2074686520776f726c642e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_15_40_51_e28ba7219d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLP>>(v1);
    }

    // decompiled from Move bytecode v6
}

