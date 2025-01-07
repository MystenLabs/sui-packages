module 0x1ea7382a5ff3c7cba259a5346ae3afa919b6600b5a74c3ac7fcde0dad2b021e::fsj {
    struct FSJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSJ>(arg0, 9, b"FSJ", b"GK", b"FD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94543be1-217e-4bc9-bad1-48830f4cfdd8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

