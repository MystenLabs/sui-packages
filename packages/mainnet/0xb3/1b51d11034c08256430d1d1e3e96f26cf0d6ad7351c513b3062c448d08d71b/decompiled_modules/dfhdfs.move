module 0xb31b51d11034c08256430d1d1e3e96f26cf0d6ad7351c513b3062c448d08d71b::dfhdfs {
    struct DFHDFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFHDFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFHDFS>(arg0, 9, b"DFHDFS", b"KJHHDF", b"BBCHDF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/059b7ee8-9e94-4741-bd61-a1a1ffcb6db8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFHDFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFHDFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

