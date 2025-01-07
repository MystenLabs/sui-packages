module 0x69683b6b34652bd8b5386c10acd07a8220643c4daab4e4f593ed6fb2418a547a::zzz {
    struct ZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZ>(arg0, 6, b"ZZZ", b"AAA", b"ZZZZZZZZZZZZ ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ON_Wqlvbz_400x400_9a1e2cb450.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

