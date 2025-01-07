module 0x381325bfe5073e81b9c1acc970f30cc30921c0f0864921c9fba26c3cbfbe18f3::jawad {
    struct JAWAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAWAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAWAD>(arg0, 9, b"JAWAD", b"Rana", b"This is a nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1fef6b01-a58f-4b19-ba79-233258f17ae7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAWAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAWAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

