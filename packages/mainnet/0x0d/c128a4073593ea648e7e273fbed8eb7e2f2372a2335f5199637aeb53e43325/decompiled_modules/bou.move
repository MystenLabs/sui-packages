module 0xdc128a4073593ea648e7e273fbed8eb7e2f2372a2335f5199637aeb53e43325::bou {
    struct BOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOU>(arg0, 9, b"BOU", b"BOU", b"BOUcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOU>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

