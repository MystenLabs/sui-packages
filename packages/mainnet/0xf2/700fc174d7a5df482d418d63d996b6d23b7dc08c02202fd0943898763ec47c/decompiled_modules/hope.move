module 0xf2700fc174d7a5df482d418d63d996b6d23b7dc08c02202fd0943898763ec47c::hope {
    struct HOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPE>(arg0, 6, b"HOPE", b"SuiHope", b"$HOPE: Soaring High with the Sui Rainbow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieu4pnx7ji6etlldrktvhkznxybvhlgr5stuo5gmbr2fqjg24pxye")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

