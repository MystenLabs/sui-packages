module 0x60f852494a24ec7368cd36651f6acf47988b59e54e9ac5a409b02f1621c84d0a::amsh {
    struct AMSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMSH>(arg0, 9, b"AMSH", b"Amsha", b"Symbol for love and Compassion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db1bba2b-0601-4d21-a5e3-87003588de9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

