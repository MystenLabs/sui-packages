module 0xf3bcd82fc2879a6f9e23f749ee1933382c4dca23e08f90c575024e73f8815a55::memebox {
    struct MEMEBOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEBOX>(arg0, 9, b"MEMEBOX", b"ARB", b"sdsdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/ed75b517-12fb-49ad-947f-5473bf718f7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEBOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEBOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

