module 0xbbc14680627f1452163e8ff439af8d022cb6282d51e991382c86a1262c4bbb49::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 6, b"Panda", b"Sui Panda", b"Pandas symbolize peace, balance, and playfulness. In modern culture, theyve become symbols of soft power, eco-awareness, and even meme culture, often portrayed as cute, lazy, yet unexpectedly powerful.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieel6vxkmxtmmpgx5pteebtlvlossmayixke2eh3opy6dtgjsmzxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PANDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

