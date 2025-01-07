module 0x747d34f27497a01e49b48e0051cccad672e336ddeb2ed4030bde9aa3ab784e5::testr {
    struct TESTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTR>(arg0, 9, b"TESTR", b"TESTR", b"TESTIUR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTR>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

