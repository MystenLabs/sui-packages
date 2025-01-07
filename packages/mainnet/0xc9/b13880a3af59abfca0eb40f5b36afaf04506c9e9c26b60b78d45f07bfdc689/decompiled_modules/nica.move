module 0xc9b13880a3af59abfca0eb40f5b36afaf04506c9e9c26b60b78d45f07bfdc689::nica {
    struct NICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICA>(arg0, 9, b"NICA", b"Nigga Cat", b"Just meme just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c2890ff-acf2-47f2-91f0-761d4a98d19a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

