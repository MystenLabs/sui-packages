module 0x3b176dd35bf033b6e39e5cbc772e7797de82408b1471b9a4d909f26fd82c37ac::dubiftu {
    struct DUBIFTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUBIFTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUBIFTU>(arg0, 9, b"DUBIFTU", b"KhoaDang", x"c490e1baa775207472c3aa6e20c491e1baa7752064c6b0e1bb9b69203220c491e1baa775206e68c6b02031", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/197dd627-3340-42cc-bc95-d5b92252fe5b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUBIFTU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUBIFTU>>(v1);
    }

    // decompiled from Move bytecode v6
}

