module 0x4e47500b7829f13800b771e5658ab22e0d55504f5c20e31c5a74d7f9febab541::suirock {
    struct SUIROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIROCK>(arg0, 6, b"SUIROCK", b"Rock", x"24535549524f434b20696e7370697265642062792074686520736572656e6520616374206f6620726f636b20737461636b696e67206f6e2077617465722c2073796d626f6c697a65732073746162696c69747920616e642062616c616e636520696e207468652063727970746f20776f726c642e0a236d696e6466756c6e657373202368617070696e657373202373746f70776172", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rock_e0d29e2ff3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

