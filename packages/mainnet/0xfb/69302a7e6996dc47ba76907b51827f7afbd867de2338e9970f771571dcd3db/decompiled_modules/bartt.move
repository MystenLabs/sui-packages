module 0xfb69302a7e6996dc47ba76907b51827f7afbd867de2338e9970f771571dcd3db::bartt {
    struct BARTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARTT>(arg0, 6, b"BARTT", b"Sui BARTT", b"$BARTT. Merges the iconic characters of Brett and Bart Simpson into the Trenches of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidaczhuuvloglms4bxlswozaxrpgcqsyth54jnx5np52exsokf3xu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BARTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

