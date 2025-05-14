module 0xfda7d577f1b8736837bb3abce86dcade58977487304fd5dafa365f114b4644cf::stitch {
    struct STITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STITCH>(arg0, 6, b"Stitch", b"The Extraterrestrial dog", b"The only extraterrestrial dog now in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihm5iiu37gfcmd2kv7rrzlzl57hleq3xbqqc7a3s67p3klefrtjcu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STITCH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

