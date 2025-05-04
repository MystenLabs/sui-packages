module 0xb2e510ec186abeb57393ee957a6efd1bdfa4a5f3c6bf1682b7211684d6394e6c::btester {
    struct BTESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTESTER>(arg0, 9, b"btester", b"btester", b"its a test just chill.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTESTER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTESTER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTESTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

