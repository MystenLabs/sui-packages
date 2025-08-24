module 0x8445554edf6ee2f1f531c4a95f4143f5fa73b8d09933d58e436dfb67ef3c9851::dbear {
    struct DBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBEAR>(arg0, 6, b"DBEAR", b"Doped Bear", b"A cheeky meme coin starring a laid back,  joint-rolling bear who thrives in a bear market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig4qkmdbxbrq3sdaa34yz3h2vmeknxqycp3rkcx7rujnorpd2dl44")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DBEAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

