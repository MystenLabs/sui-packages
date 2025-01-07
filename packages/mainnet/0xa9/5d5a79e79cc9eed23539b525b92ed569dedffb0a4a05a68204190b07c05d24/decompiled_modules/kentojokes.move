module 0xa95d5a79e79cc9eed23539b525b92ed569dedffb0a4a05a68204190b07c05d24::kentojokes {
    struct KENTOJOKES has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENTOJOKES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENTOJOKES>(arg0, 9, b"KENTOJOKES", b"Kenneth", b"Depression ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79dd9224-63f9-40af-bd39-7608985ac47e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENTOJOKES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENTOJOKES>>(v1);
    }

    // decompiled from Move bytecode v6
}

