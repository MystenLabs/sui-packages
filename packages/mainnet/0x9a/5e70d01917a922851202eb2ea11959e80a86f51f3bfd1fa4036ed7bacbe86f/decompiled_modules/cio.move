module 0x9a5e70d01917a922851202eb2ea11959e80a86f51f3bfd1fa4036ed7bacbe86f::cio {
    struct CIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIO>(arg0, 6, b"CIO", b"Community is Over", b"Community is Over no twitter no telegram no everything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/66d76587_5833_483e_9449_75fc73b47ee6_bb939be1ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

