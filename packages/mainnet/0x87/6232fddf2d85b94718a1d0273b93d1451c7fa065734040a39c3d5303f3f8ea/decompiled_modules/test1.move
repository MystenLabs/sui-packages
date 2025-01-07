module 0x876232fddf2d85b94718a1d0273b93d1451c7fa065734040a39c3d5303f3f8ea::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 9, b"TEST1", b"TEST", b"This is token TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d0bf842d-c5dc-4ed3-b8b9-f4321f477ecf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST1>>(v1);
    }

    // decompiled from Move bytecode v6
}

