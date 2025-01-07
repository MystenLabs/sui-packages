module 0xa5001e0ac33254d7b32a6a686ffa024a2c4506884b88eae5400d02b9e4d889ea::grld {
    struct GRLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRLD>(arg0, 9, b"GRLD", b"GRAY LADY", b"GRAY LADI IS LOUNCHES HER TOKENS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1fb1901-8931-4d90-a215-1e43835b54b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

