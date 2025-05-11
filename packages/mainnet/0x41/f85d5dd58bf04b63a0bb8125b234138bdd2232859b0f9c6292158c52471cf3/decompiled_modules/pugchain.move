module 0x41f85d5dd58bf04b63a0bb8125b234138bdd2232859b0f9c6292158c52471cf3::pugchain {
    struct PUGCHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGCHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGCHAIN>(arg0, 6, b"PUGCHAIN", b"Pugchain", x"2450554720436f696e206973206e6f74206a75737420616e6f746865722063727970746f63757272656e63796974732074686520667574757265206f6620646563656e7472616c697a65642066696e616e63652e204275696c74206f6e20696e6e6f766174696f6e2c2074727573742c20616e6420636f6d6d756e6974792c2077652061696d20746f207265766f6c7574696f6e697a6520746865206469676974616c2065636f6e6f6d792062792070726f766964696e672073656375726520616e6420656666696369656e7420626c6f636b636861696e20736f6c7574696f6e732e0a0a20496e6e6f766174696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068788_443dbfc31e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGCHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGCHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

