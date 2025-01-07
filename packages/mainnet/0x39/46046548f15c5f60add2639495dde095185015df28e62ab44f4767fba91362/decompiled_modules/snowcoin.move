module 0x3946046548f15c5f60add2639495dde095185015df28e62ab44f4767fba91362::snowcoin {
    struct SNOWCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWCOIN>(arg0, 9, b"SNOWCOIN", b"SNOWCOIN", b"ITS A SNOWY COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNOWCOIN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWCOIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

