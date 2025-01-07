module 0x993b42d2fa50a306fde4f20bc3ab5c26f328ca9dbbe4955bead24abc43a42197::babycrabs {
    struct BABYCRABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYCRABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYCRABS>(arg0, 9, b"BABYCRABS", b"Crabs", b"Crabs King Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd71f81d-1626-41fe-8ddf-883428eb5826.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYCRABS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYCRABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

