module 0xca06ad7e6df6281ca896afaf458164bf8859162648d1c202fd75e05cb452377c::memecat {
    struct MEMECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECAT>(arg0, 9, b"MEMECAT", b"Minicat1 ", b"Minicat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2a37876-bb14-426d-ba69-254770c5a7bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

