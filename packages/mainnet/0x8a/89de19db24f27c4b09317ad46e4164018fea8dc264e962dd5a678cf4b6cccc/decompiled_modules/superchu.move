module 0x8a89de19db24f27c4b09317ad46e4164018fea8dc264e962dd5a678cf4b6cccc::superchu {
    struct SUPERCHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERCHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERCHU>(arg0, 6, b"SUPERCHU", b"SUPERKACHU", b"$SuperKachu the superKachu who comes to electrify the blockchain #sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicxg2ki7bia2kbesltukdrw5lxlyx5z2oyhpvgp5sqfx4gw2rlray")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERCHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUPERCHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

