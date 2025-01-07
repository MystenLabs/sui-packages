module 0x8675dd879401d8df2ad49f424c0be30b7dcd4df8ae2a14fb951ef844e40918d9::pukie {
    struct PUKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUKIE>(arg0, 6, b"PUKIE", b"PUKIE CAT", x"4d6565742050756b6965204361742c20746865206c61746573740a73656e736174696f6e206c6976696e67206f6e20746865205375690a626c6f636b636861696e212050756b69652043617420697320612066756e0a616e6420717569726b79206469676974616c207065742c206272696e67696e670a6a6f7920746f207468652063727970746f20636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731368506824.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUKIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUKIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

