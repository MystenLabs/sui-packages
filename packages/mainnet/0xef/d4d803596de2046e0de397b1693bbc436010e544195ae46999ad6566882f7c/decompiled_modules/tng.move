module 0xefd4d803596de2046e0de397b1693bbc436010e544195ae46999ad6566882f7c::tng {
    struct TNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNG>(arg0, 6, b"TNG", b"Troll N Go", b"Just meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifmiwt56hyl3gunfjapq4bozafb6pfj44hlk3d7jaj2nfpghd4uui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TNG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

