module 0xf33bdc280faf4bd0411cac82173b5744b7a40e4b9abc0ad6f51a495c060faf77::culo {
    struct CULO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULO>(arg0, 6, b"CULO", b"CULOSUI", b"The cheekiest meme token on Sui! Join the rumpus, moon with us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihw22w4ofapvynf3czp4qffviybcvvpwzj62jujrjjqurljtutq3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CULO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

