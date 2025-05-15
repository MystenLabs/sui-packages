module 0x1c92eab011206d4eea82e1feab18e5c8279b832b5e4e7cb45c30e6cac7fefe51::rachu {
    struct RACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACHU>(arg0, 6, b"RACHU", b"RAICHU", x"526169636875206973206120626c6f636b636861696e20616476656e7475726520776865726520747261696e6572732063617074757265206469676974616c20506f6bc3a96d6f6e2c2074726164652077697468202452616963687520746f6b656e732c20616e6420626174746c6520696e20636f736d6963206172656e61732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibev67s5rsetwyfrtobxmqkivzvpnjcakbp57nfxjh5gkv5fcuh3e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RACHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

