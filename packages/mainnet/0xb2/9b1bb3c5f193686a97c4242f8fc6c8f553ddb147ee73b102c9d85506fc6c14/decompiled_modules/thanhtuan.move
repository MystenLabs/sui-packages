module 0xb29b1bb3c5f193686a97c4242f8fc6c8f553ddb147ee73b102c9d85506fc6c14::thanhtuan {
    struct THANHTUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: THANHTUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THANHTUAN>(arg0, 9, b"THANHTUAN", b"Thanh", b"I like it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b09d6bd-4640-450d-84c9-4f6971b7d339.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THANHTUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THANHTUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

