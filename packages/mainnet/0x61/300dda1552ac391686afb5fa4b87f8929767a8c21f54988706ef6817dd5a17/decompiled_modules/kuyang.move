module 0x61300dda1552ac391686afb5fa4b87f8929767a8c21f54988706ef6817dd5a17::kuyang {
    struct KUYANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUYANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUYANG>(arg0, 9, b"KUYANG", b"kuyang", b"Kuyang is a stealth that is the form of a human head without skin and limbs. I'm flying looking for baby blood or the blood of a new woman.Kuyang is a woman who studies black magic to achieve eternal life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/440b5d07-479f-4252-bd96-b0751c316237.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUYANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUYANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

