module 0x7ad4545fd693ef3fef19808898cf9c379814e47aa0d5dee79e1e2e5028d76f2c::hank {
    struct HANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANK>(arg0, 9, b"HANK", b"Hank", b"Hank Scorpio Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lossimpsonsexplicados.com/wp-content/uploads/2018/12/hank-scorpio.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HANK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANK>>(v2, @0xc3d15f743ae7f8bff036154c2a066fde02248248032112f041369861d613dc07);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

