module 0xcdf5385cb8a4173fc0de25fb78bb06ce0eb3fd24aa400f3b4031956ad6c8631e::cp {
    struct CP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CP>(arg0, 9, b"CP", b"CUP", b"sdcdffdv hujy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4b3a43cad9f51c5604289ffd875ca406blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

