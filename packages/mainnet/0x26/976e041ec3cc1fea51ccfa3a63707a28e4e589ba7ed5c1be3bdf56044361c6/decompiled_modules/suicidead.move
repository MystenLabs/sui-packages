module 0x26976e041ec3cc1fea51ccfa3a63707a28e4e589ba7ed5c1be3bdf56044361c6::suicidead {
    struct SUICIDEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDEAD>(arg0, 9, b"Suicidead", b"Suicidead", b"No Memes No Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICIDEAD>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDEAD>>(v2, @0x67118f3a564e7fe93f4cb638d46f75ac8b457148079c8531881710a69153379e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICIDEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

