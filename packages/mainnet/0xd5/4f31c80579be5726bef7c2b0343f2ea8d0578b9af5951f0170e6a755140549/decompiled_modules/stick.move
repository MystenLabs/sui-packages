module 0xd54f31c80579be5726bef7c2b0343f2ea8d0578b9af5951f0170e6a755140549::stick {
    struct STICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STICK>(arg0, 9, b"STICK", b"Stick to t", b"just stick to the plan ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a9e8804-d824-4b67-9970-9a18f06fa62f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

