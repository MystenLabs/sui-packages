module 0xe8f36876fb3142b51bc983d6b5fd1ae473e758ace00754f10b891539e55f25a5::pewpaw {
    struct PEWPAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEWPAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEWPAW>(arg0, 9, b"Pewpaw", b"pew paw ", b"for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fd50392a4a58dbc71355f28263c9eb69blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEWPAW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEWPAW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

