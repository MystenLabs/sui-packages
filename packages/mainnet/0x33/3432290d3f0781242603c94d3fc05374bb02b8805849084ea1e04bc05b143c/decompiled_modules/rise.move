module 0x333432290d3f0781242603c94d3fc05374bb02b8805849084ea1e04bc05b143c::rise {
    struct RISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RISE>(arg0, 6, b"RISE", b"NASA ZGI Moon Mascot", b"Built on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie7szzxw7vrorzj6u74seitxrrx747akrmer6zon5pblhgsxqm2kq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RISE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

