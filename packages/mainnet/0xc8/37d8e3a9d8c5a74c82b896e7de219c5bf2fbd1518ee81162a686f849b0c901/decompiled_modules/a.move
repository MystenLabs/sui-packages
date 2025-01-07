module 0xc837d8e3a9d8c5a74c82b896e7de219c5bf2fbd1518ee81162a686f849b0c901::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A>(arg0, 6, b"A", b"f", b"fdg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731446022192.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

