module 0x29355260667ea4cca45e6bb9b2edab578cee3dbefd594b234c2ed4ac2ed0d3ee::tetrisui {
    struct TETRISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETRISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETRISUI>(arg0, 6, b"Tetrisui", b"Tetris", b"Tetris sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiejyuycjmjreigbfjedvryllpnufgm76jbdpl4cwqipgz56bu3yle")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETRISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TETRISUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

