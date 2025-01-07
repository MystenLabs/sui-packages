module 0xb38772413551eab2536a1e4f19941b5df0d4b222a3674f50f069ec1a89a7a00d::suicousin {
    struct SUICOUSIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOUSIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOUSIN>(arg0, 9, b"suicousin", b"Suicousin", b"cousin of suiman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICOUSIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOUSIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOUSIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

