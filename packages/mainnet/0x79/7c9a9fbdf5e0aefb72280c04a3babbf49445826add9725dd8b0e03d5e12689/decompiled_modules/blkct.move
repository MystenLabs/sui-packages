module 0x797c9a9fbdf5e0aefb72280c04a3babbf49445826add9725dd8b0e03d5e12689::blkct {
    struct BLKCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLKCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLKCT>(arg0, 9, b"BLKCT", b"Black cat", b"This memecoin originates from a black coloured cat which eent viral on internet due to its similarity in facial expression which looks just like a hopeless human. It is also used in many video and picture memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1900c9b-4e0c-418e-9a51-4c860024979d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLKCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLKCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

