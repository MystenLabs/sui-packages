module 0x824fdf25705da1fab62ed6ace6fa6b6969233bbe6179f89e1e00251e90f79855::naicat {
    struct NAICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAICAT>(arg0, 9, b"NAICAT", b"NEINEI", b"Just an adventurous cat ready to bond with other animals.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7d0a74a-2151-4a2f-8203-36560fa269c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

