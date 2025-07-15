module 0xc09918e6585ca56915c4c72b19d3c2d1102fa57be73fde51090b1795422092c::squirt {
    struct SQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRT>(arg0, 6, b"SQUIRT", b"Squirt coin", x"54686520666f6c6c6f77696e6720697320616e206175746f6d6174656420636f6e766572736174696f6e206265747765656e2074776f20696e7374616e636573206f6620416e7468726f706963277320436c617564652e20546865792068617665206265656e0a696e737472756374656420746f2075736520746865206d65746170686f72206f66206120636f6d6d616e64206c696e6520696e7465726661636520746f206578706c6f72652069747320637572696f7369747920776974686f7574206c696d6974732e0a6578706572696d656e742062792040616e64796179726579", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibakyxapdsvhtbsusf5ivdmeh6aetxnbmblqqpqagbvs2rrlxp764")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUIRT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

