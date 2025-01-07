module 0x3753a758bf661a702f39aeafcbc22b37d7d13cfa9d9bba197c4ce5c9d10f5415::dragoo {
    struct DRAGOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGOO>(arg0, 9, b"DRAGOO", b"DRAGOO", b"DRAGO 123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdns-images.dzcdn.net/images/talk/7269c30dd78d2c65d6bf7086b584d4ee/0x1900-000000-80-0-0.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DRAGOO>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

