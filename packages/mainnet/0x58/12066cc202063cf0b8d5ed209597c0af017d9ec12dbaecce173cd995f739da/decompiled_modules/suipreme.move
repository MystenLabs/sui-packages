module 0x5812066cc202063cf0b8d5ed209597c0af017d9ec12dbaecce173cd995f739da::suipreme {
    struct SUIPREME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPREME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPREME>(arg0, 6, b"SUIPREME", b"Suipreme", b"SUIPREME mfacka!! https://t.me/suipreme_one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/pJHZ1rw/photo-2024-10-12-03-51-32.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPREME>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPREME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPREME>>(v1);
    }

    // decompiled from Move bytecode v6
}

