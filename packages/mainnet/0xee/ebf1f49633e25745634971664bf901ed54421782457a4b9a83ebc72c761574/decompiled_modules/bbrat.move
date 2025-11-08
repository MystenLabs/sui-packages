module 0xeeebf1f49633e25745634971664bf901ed54421782457a4b9a83ebc72c761574::bbrat {
    struct BBRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBRAT>(arg0, 9, b"BBRAT", b"BABY BRAT", b"Its a baby brat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBRAT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBRAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

