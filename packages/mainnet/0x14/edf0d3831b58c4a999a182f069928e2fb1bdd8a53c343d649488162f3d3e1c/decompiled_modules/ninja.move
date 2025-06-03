module 0x14edf0d3831b58c4a999a182f069928e2fb1bdd8a53c343d649488162f3d3e1c::ninja {
    struct NINJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINJA>(arg0, 6, b"NINJA", b"Ninja on Sui", b"Keir my friend. It isnt the ninja swords. It the ninjas. IYKYK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig6ymwi3gnkyrlfhgd4mfqt26j4ylao4oqz75yxbc4zdarxc4ankq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NINJA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

