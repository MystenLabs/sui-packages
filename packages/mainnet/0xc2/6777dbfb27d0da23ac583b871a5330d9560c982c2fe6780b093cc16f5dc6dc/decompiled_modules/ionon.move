module 0xc26777dbfb27d0da23ac583b871a5330d9560c982c2fe6780b093cc16f5dc6dc::ionon {
    struct IONON has drop {
        dummy_field: bool,
    }

    fun init(arg0: IONON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IONON>(arg0, 6, b"ionon", b"iujn", b"oin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IONON>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IONON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IONON>>(v1);
    }

    // decompiled from Move bytecode v6
}

