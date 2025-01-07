module 0xebf202332649f86b29933f366f4ccc6cd4965fbc0cd65b01b757f2476cf37a40::ta {
    struct TA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TA>(arg0, 9, b"ta", b"a", b"52", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TA>>(v1);
    }

    // decompiled from Move bytecode v6
}

