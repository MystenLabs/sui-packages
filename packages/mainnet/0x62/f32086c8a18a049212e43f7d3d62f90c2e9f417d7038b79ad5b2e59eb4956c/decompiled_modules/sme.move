module 0x62f32086c8a18a049212e43f7d3d62f90c2e9f417d7038b79ad5b2e59eb4956c::sme {
    struct SME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SME>(arg0, 9, b"SME", b"Sam Meme", b"A Meme token for Sam and Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eba1c272-d56a-4764-a310-16a4d9a26034.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SME>>(v1);
    }

    // decompiled from Move bytecode v6
}

