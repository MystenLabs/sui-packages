module 0x379c517ffe90b1baeafa0d677fc96c97c35fd015aa97ef10093ad981a9d7d7a5::pzilla {
    struct PZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PZILLA>(arg0, 6, b"PZILLA", b"Pepe Zilla", b"PepeZilla is the chaotic meme coin of the sui jungle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaowr7yzszoy3lqznqho3ablfd4zadvfiysaxfsbkmptv3wzvnigy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PZILLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

