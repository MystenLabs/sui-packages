module 0x8d875919dd3e306f1144a9b19a746399764339cf795bbf4320cdcc1370cf0147::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 9, b"BOB", b"bobo", b"bob land", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/978619935fdb3f1e4d322376c1d0d3e4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

