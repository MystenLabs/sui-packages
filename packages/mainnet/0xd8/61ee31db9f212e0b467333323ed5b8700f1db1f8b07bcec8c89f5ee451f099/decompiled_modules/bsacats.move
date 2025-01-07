module 0xd861ee31db9f212e0b467333323ed5b8700f1db1f8b07bcec8c89f5ee451f099::bsacats {
    struct BSACATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSACATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSACATS>(arg0, 9, b"BSACATS", b"Bsacats", b"BSA CATS is a meme token for cat lovers all over the world, just to express the feelings of all humans towards cats.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef6f30ac-88b1-4b5a-9398-c8bfd45fb2dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSACATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSACATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

