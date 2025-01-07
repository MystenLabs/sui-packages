module 0xd5c07d215efea99e2bd854ec1c3a9e8ccc35436a4a0243daff750b683632d60::fierycat {
    struct FIERYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIERYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIERYCAT>(arg0, 9, b"FIERYCAT", b"FIERY", b"A FAIRY CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c97d3d8c-2407-4100-aacf-cd5391925394.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIERYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIERYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

