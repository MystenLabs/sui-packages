module 0x5d72772eb3c7071c31a25cdebee801d65bf24485e3ed9aaee75ee93d2b7d220::neo {
    struct NEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEO>(arg0, 9, b"NEO", b"pro", b"bro trust once", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/81927ca6786b9013d8274a3994afb7dablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

