module 0x998d42449a3b2f370e6b3ea81b488f5fbf19d09a0e0d8f8d46065d7417393bf::akk {
    struct AKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKK>(arg0, 9, b"AKK", b"akki", b"ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c32a18c99f7775e9a613f595988ac499blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

