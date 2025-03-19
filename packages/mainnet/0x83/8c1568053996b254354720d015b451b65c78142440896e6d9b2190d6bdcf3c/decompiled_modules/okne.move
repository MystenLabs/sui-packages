module 0x838c1568053996b254354720d015b451b65c78142440896e6d9b2190d6bdcf3c::okne {
    struct OKNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKNE>(arg0, 9, b"OKNE", b"OKHOCAI", b"jefjlks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/713f31fa1926a2386dedb7198ad9287dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OKNE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKNE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

