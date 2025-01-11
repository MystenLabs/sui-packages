module 0xecf514a02165256b25e900a68425c70729cdafcd9b8d9d267aad415135b01f20::hehe2 {
    struct HEHE2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHE2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHE2>(arg0, 9, b"HEHE3", b"HEHE3", b"Hehehehehehehehehehehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzqBvzdVf-9AKTWLtxFIOKkqPY_K9pOViKMA&s")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEHE2>>(v1);
        0x2::coin::mint_and_transfer<HEHE2>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HEHE2>>(v2);
    }

    // decompiled from Move bytecode v6
}

