module 0xe24a07d21e97dc57c72fa2a314ddd2cfaef5557ecfc94669d03fc625dc742881::csgo {
    struct CSGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSGO>(arg0, 9, b"CSGO", b"CSGO", b"CSGO Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CSGO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

