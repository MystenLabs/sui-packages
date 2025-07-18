module 0x3d8f52b9f85e9b0d05fde771a2aa0557c15aaf6c875837ce0d0efc9d529a5d3d::shrak {
    struct SHRAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRAK>(arg0, 6, b"SHRAK", b"Shark Dragon", b"Shark token on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreielvfl5desnjwkweema7cv3mhcqa32xvqxyxc7bpgd65ulwxdqz6a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHRAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

