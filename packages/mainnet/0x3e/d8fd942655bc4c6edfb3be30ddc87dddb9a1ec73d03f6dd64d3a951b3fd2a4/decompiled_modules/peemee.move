module 0x3ed8fd942655bc4c6edfb3be30ddc87dddb9a1ec73d03f6dd64d3a951b3fd2a4::peemee {
    struct PEEMEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEMEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEMEE>(arg0, 9, b"PEEMEE", b"Peeme ", b"Car say mee ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dff6c800-fa7c-4a73-8bfb-96451dded6b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEMEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEEMEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

