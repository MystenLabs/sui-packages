module 0x262bc18f7ceee83883e2a011b40c432025b38de4a74fa49e9999e4c18a4b6a41::yannah {
    struct YANNAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: YANNAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YANNAH>(arg0, 6, b"Yannah", b"Yannah the Dawg", b"Yannah the Dawg si a meme token born on Sui inspired by a Pet dog who doesn't bark but only bite!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihhkm5hmlek3x5eqou6jphw7sxn6fiptuhhwurwp2fsaiwctlsmoa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YANNAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YANNAH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

