module 0x8187a68701910a44958f5a8b7990b4624d2745588d943382ea276e5814d066fa::a1 {
    struct A1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A1>(arg0, 6, b"A1", b"ABC", b"1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_92940746ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A1>>(v1);
    }

    // decompiled from Move bytecode v6
}

