module 0x2a4fc2e88bf15aea60f88ac146831c88df2ccec69851a6ec4d0a2912ab69d8ab::blkct {
    struct BLKCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLKCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLKCT>(arg0, 9, b"BLKCT", b"Black cat", b"This memecoin originates from a black coloured cat which eent viral on internet due to its similarity in facial expression which looks just like a hopeless human. It is also used in many video and picture memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/480738ea-81cf-4c0d-ab73-f86075e9e172.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLKCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLKCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

