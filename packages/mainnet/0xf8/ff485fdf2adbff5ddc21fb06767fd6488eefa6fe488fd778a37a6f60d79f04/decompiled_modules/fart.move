module 0xf8ff485fdf2adbff5ddc21fb06767fd6488eefa6fe488fd778a37a6f60d79f04::fart {
    struct FART has drop {
        dummy_field: bool,
    }

    fun init(arg0: FART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FART>(arg0, 6, b"Fart", b"Fartdao", b"Dao", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidrrnmbj7tdxzbipz32yw3n55fpo22q45ufafb5dzczebqg5z7ab4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FART>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

