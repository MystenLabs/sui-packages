module 0x48b71c01b9af23d187dba5e2b7e901dff1f5e7f95efb1677b95fc27745ce0edc::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 2, b"BLUB", b"BLUB v2 (bridge at: blubv2.com)", b"complete bride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.cryptorank.io/coins/blub1726144519211.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUB>(&mut v2, 30000000000000000 * 0x1::u64::pow(10, 2), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

