module 0x94398011cd3e54cee623b10e56138144f94602bf60e33717f9ba5910276c3c68::ivy {
    struct IVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVY>(arg0, 9, b"IVY", b"ivys", b"fun only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/eade56960c50cde511822bf48098cbe1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

