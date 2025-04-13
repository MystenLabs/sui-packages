module 0x1791fc26785dd6774d2ea92da44d93b523c3b332a2cd7a1f92fecde7866e4fc2::rot {
    struct ROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROT>(arg0, 6, b"ROT", b"Brainrot Anomaly", x"42616c6c6572696e6120636170707563696e610a74756e672074756e672074756e672074756e672053414855520a7472616c616c656c6f207472616c616c610a626f6d62617264696e6f2063726f636f64696c6f0a636170707563696e6f206173736173696e6f0a74726970692074726f70690a626f6e65636120616d62616c6162750a7368696d70616e73696e6e692062616e616e696e690a6c6172696c696e206c6172696c610a626f6d626f6d62696e6920677573696e690a62727220627272207061746170696d0a7472697070692074726f707069207472697070692074726f707061", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled1112_20250413152151_33af516534.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

