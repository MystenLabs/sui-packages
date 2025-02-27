module 0x7c7f39b8e602e843d0c183cbb47b02dace4fdde4dd8ab859e3b4c20de29c4334::stev {
    struct STEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEV>(arg0, 9, b"stev", b"StevCoin", b"A new token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STEV>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

