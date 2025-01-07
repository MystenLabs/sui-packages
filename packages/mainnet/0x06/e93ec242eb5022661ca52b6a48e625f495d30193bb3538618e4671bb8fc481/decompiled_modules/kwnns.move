module 0x6e93ec242eb5022661ca52b6a48e625f495d30193bb3538618e4671bb8fc481::kwnns {
    struct KWNNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWNNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWNNS>(arg0, 9, b"KWNNS", b"jaja", b"bwbe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4db1e3fb-c2da-41a0-9558-a9d5f5e08d24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWNNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KWNNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

