module 0x35b7c9efb61ca6816a1ede59bf1652fe507752252f79953fdab0c72f6cf1aa7d::dev {
    struct DEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV>(arg0, 6, b"DEV", b"DEV IL", b"This is DEV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidqqzsshv72o5kymtkoqdfjc2aabdgaxn5rpdl3kd5h34harpyoy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

