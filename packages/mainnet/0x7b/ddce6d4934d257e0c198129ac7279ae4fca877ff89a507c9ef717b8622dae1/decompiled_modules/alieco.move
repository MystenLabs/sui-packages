module 0x7bddce6d4934d257e0c198129ac7279ae4fca877ff89a507c9ef717b8622dae1::alieco {
    struct ALIECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIECO>(arg0, 6, b"ALIECO", b"ALIEN COIN", b"Alien Coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibjnnauinzrrv4z3olszwr2iqp7gn5ndz2rtdpuqvpx2fxrv4ttam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALIECO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

