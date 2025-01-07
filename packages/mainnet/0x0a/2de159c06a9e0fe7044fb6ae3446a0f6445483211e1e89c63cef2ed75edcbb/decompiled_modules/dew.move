module 0xa2de159c06a9e0fe7044fb6ae3446a0f6445483211e1e89c63cef2ed75edcbb::dew {
    struct DEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEW>(arg0, 6, b"DEW", b"SUIDEW", x"5375696465773a2041206d656d6520746f6b656e206f6e207468652053756920626c6f636b636861696e2c20756e6974696e6720766972616c2068756d6f722c207374726f6e6720636f6d6d756e697479207370697269742c20616e64207363616c6162696c6974792e0a0a4a6f696e207573206f6e2054656c656772616d0a0a0a68747470733a2f2f742e6d652f7375696465775f636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250108_022816_851_a1e3c93dce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

