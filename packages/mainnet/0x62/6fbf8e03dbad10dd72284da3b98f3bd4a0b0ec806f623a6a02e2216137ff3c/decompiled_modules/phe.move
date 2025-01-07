module 0x626fbf8e03dbad10dd72284da3b98f3bd4a0b0ec806f623a6a02e2216137ff3c::phe {
    struct PHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHE>(arg0, 9, b"PHE", b"PEHE", b"New Meme Pehe Good Project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa026800-3dea-4e4c-9315-980e31f53b22.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

