module 0x7a17d9e2687939667506511a2d54bb2306c149bb893fad9e6331f5e6a8aa419::chippy {
    struct CHIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPPY>(arg0, 6, b"CHIPPY", b"Chippy only the chipmunks", x"4368697070792074686520436869706d756e6b730a4865792c2049276d204368697070792c207468652077696c6465737420636869706d756e6b20796f75276c6c2065766572206d6565742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000041826_422b1b8aee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

