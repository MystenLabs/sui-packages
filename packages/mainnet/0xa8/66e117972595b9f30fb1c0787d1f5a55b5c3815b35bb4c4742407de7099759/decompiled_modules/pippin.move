module 0xa866e117972595b9f30fb1c0787d1f5a55b5c3815b35bb4c4742407de7099759::pippin {
    struct PIPPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPPIN>(arg0, 9, b"pippin", b"Pippin On Sui", x"796f6865696e616b616a696d61202264657461696c656420756e69636f726e22200d0a0d0a68747470733a2f2f782e636f6d2f796f6865696e616b616a696d612f7374617475732f31383535333337383837353638363338343331", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdcvSSBg7gWD4tvfXv3PuLtAiPyDZ5Z9w4LQVeRJKL3Lz")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIPPIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPPIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPPIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

