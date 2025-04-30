module 0x1b980e7af0dad6d0f6f0e7ed3875f2b281e5ecbd4ac4bc28a1bd334ac986177f::dinosuirus {
    struct DINOSUIRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINOSUIRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINOSUIRUS>(arg0, 9, b"DINOSUIRUS", b"DINOSAUR SUI", b"FUN TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/de7a46ef4f7aaf643d40b9f85f17fb96blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINOSUIRUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINOSUIRUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

