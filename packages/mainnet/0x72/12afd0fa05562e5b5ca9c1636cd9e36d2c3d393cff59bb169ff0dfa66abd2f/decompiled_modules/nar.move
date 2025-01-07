module 0x7212afd0fa05562e5b5ca9c1636cd9e36d2c3d393cff59bb169ff0dfa66abd2f::nar {
    struct NAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAR>(arg0, 9, b"NAR", b"Narwhale", b"LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/172283417?s=400&u=5332c09ace5b09348737671c80cf000e5e57983c&v=4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

