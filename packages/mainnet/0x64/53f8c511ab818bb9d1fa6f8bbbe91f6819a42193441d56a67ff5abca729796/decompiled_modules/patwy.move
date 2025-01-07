module 0x6453f8c511ab818bb9d1fa6f8bbbe91f6819a42193441d56a67ff5abca729796::patwy {
    struct PATWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATWY>(arg0, 6, b"PATWY", b"Sui Patwy", b"PATWY -  the cute Memecoin that will become an icon on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014727_a7931bb37f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

