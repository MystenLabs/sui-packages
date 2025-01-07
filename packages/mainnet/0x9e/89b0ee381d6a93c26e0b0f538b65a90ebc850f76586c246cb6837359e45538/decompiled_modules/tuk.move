module 0x9e89b0ee381d6a93c26e0b0f538b65a90ebc850f76586c246cb6837359e45538::tuk {
    struct TUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUK>(arg0, 9, b"TUK", b"TUKKO", b"AAA-TUKKO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0d9568c-5bdc-446b-a51f-a207ed8ff262.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

