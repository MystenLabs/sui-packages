module 0xd2581fd6a08116f16ae50b79af7b7a05d2cff067b717387890cefe3418aa347d::thelongesttokentickerevenseeniinthisplanetblockchainmaybeotherone {
    struct THELONGESTTOKENTICKEREVENSEENIINTHISPLANETBLOCKCHAINMAYBEOTHERONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: THELONGESTTOKENTICKEREVENSEENIINTHISPLANETBLOCKCHAINMAYBEOTHERONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THELONGESTTOKENTICKEREVENSEENIINTHISPLANETBLOCKCHAINMAYBEOTHERONE>(arg0, 9, b"THELONGESTTOKENTICKEREVENSEENIINTHISPLANETBLOCKCHAINMAYBEOTHERONE", b"Test Coin", b"Test Desciption", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<THELONGESTTOKENTICKEREVENSEENIINTHISPLANETBLOCKCHAINMAYBEOTHERONE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THELONGESTTOKENTICKEREVENSEENIINTHISPLANETBLOCKCHAINMAYBEOTHERONE>>(v2, @0xc23ea8e493616b1510d9405ce05593f8bd1fb30f44f92303ab2c54f6c8680ecb);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THELONGESTTOKENTICKEREVENSEENIINTHISPLANETBLOCKCHAINMAYBEOTHERONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

