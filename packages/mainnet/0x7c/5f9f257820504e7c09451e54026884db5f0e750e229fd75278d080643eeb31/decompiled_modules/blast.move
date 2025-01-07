module 0x7c5f9f257820504e7c09451e54026884db5f0e750e229fd75278d080643eeb31::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAST>(arg0, 9, b"BLAST", b"Blast", b"BLASTIC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56f53105-8d9e-4f6d-afeb-8c2955c517e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

