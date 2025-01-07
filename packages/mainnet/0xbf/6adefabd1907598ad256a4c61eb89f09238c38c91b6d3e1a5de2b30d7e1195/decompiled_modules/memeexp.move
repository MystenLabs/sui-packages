module 0xbf6adefabd1907598ad256a4c61eb89f09238c38c91b6d3e1a5de2b30d7e1195::memeexp {
    struct MEMEEXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEEXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEEXP>(arg0, 6, b"MemeExp", b"Meme Express", x"2242756c6c6574205370656564204d656d6573206f6e2053756920426c6f636b636861696e220a5368696e6b616e73656e2042756c6c657420547261696e204d656d6520457870726573732c207768657265204a6170616e27732069636f6e696320747261696e206d6565747320626c6f636b636861696e20746563686e6f6c6f677921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SHIN_6_f7c8376a7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEEXP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEEXP>>(v1);
    }

    // decompiled from Move bytecode v6
}

