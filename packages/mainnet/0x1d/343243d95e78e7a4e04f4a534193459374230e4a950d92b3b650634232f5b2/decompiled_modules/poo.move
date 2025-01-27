module 0x1d343243d95e78e7a4e04f4a534193459374230e4a950d92b3b650634232f5b2::poo {
    struct POO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POO>(arg0, 9, b"POO", b"pooh", b"pooh coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e8c45e9e28612d6113393cff381ae233blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

