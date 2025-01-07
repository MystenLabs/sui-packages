module 0xa1ccc8c40472c37092af80ee69c7cfabdf6aff890b03d89d5c2bc744f4b0b592::jb {
    struct JB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JB>(arg0, 9, b"JB", b"Johnbull", b"For the OG ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e46664b-0156-4c26-9769-d415f5e9bd9d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JB>>(v1);
    }

    // decompiled from Move bytecode v6
}

