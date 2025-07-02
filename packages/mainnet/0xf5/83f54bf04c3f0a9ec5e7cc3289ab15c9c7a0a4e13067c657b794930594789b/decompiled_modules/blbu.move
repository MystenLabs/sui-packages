module 0xf583f54bf04c3f0a9ec5e7cc3289ab15c9c7a0a4e13067c657b794930594789b::blbu {
    struct BLBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLBU>(arg0, 9, b"BLBU", b"$BLBU", b"$Blbu official first token human ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d26adce3cdb5c115fe188caf2d040018blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

