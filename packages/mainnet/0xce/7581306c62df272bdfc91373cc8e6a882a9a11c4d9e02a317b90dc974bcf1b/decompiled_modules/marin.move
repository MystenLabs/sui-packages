module 0xce7581306c62df272bdfc91373cc8e6a882a9a11c4d9e02a317b90dc974bcf1b::marin {
    struct MARIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIN>(arg0, 9, b"MARIN", b"MarinaWife", b"Wife Marina mem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4275f798-1aba-4eaa-bc34-3d7d75c95c74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

