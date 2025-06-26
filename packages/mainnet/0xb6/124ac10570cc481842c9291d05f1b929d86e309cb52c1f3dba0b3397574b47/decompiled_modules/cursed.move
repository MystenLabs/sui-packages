module 0xb6124ac10570cc481842c9291d05f1b929d86e309cb52c1f3dba0b3397574b47::cursed {
    struct CURSED has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURSED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CURSED>(arg0, 6, b"CURSED", b"EVERYTHING IS CURSED", b"I found it in the static, buried in the hum of a dead signal. The word came first, sharp like a blade: CURSED. Not spoken, not written, but *felt* a weight in the air, a pulse in the dark. The screen flickered, and the archive opened.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiee7kdtrk5qpugsi3gitapnyre23lj7fv35drscpvvffy5wblw644")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURSED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CURSED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

