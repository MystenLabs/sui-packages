module 0x1d0220245ba00bca2392c5b45e8291421cdeb0d0433d8f86cb777ce187381c09::chirp {
    struct CHIRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIRP>(arg0, 9, b"CHIRP", b"Chirp meme", b"DEPIN ECOSYSTEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4a24ad7-e35f-4830-b065-123a0aae2355.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

