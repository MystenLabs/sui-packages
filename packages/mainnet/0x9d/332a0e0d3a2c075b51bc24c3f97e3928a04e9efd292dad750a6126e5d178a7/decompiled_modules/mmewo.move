module 0x9d332a0e0d3a2c075b51bc24c3f97e3928a04e9efd292dad750a6126e5d178a7::mmewo {
    struct MMEWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMEWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMEWO>(arg0, 9, b"MMEWO", b"MEOW", b"CAT CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5b343dca13a70179420f92a547452c7cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMEWO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMEWO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

