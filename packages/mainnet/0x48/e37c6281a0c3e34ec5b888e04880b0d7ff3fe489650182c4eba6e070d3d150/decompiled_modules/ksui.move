module 0x48e37c6281a0c3e34ec5b888e04880b0d7ff3fe489650182c4eba6e070d3d150::ksui {
    struct KSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSUI>(arg0, 6, b"KSUI", b"Kags", b"Ksui good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidv76kh5jte674mydrgtkrcy3v4d6ocec4kvn2zslbgxqupn6kocq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

