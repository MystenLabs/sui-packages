module 0xfd9536e2bb66928afbc6b54f873e30310c62af4105b7283d7679e3cf78d92a58::matrix {
    struct MATRIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATRIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATRIX>(arg0, 9, b"MATRIX", b"Matrix", b"The creation this coin is based on , the matrix , be free , and chase your dreams , this is for you , the matrix", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://c1.wallpaperflare.com/preview/185/698/502/matrix-communication-software-pc.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MATRIX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATRIX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATRIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

