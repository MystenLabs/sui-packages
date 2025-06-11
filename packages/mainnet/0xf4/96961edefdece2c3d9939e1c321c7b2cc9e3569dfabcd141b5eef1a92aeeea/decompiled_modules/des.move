module 0xf496961edefdece2c3d9939e1c321c7b2cc9e3569dfabcd141b5eef1a92aeeea::des {
    struct DES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DES>(arg0, 9, b"DES", b"DESTA", b"DES FOR DEAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/850843fb08264e24d6ea44ddde10389dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

