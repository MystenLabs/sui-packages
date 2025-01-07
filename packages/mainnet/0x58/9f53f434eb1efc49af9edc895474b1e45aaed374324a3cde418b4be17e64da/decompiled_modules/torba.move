module 0x589f53f434eb1efc49af9edc895474b1e45aaed374324a3cde418b4be17e64da::torba {
    struct TORBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORBA>(arg0, 9, b"TORBA", b"torba", b"REAL torba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b545c02a-8a7f-4bce-858d-bc100dedb900.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TORBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

