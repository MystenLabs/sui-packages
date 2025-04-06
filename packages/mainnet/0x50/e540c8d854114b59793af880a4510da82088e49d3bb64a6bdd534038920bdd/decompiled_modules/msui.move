module 0x50e540c8d854114b59793af880a4510da82088e49d3bb64a6bdd534038920bdd::msui {
    struct MSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSUI>(arg0, 9, b"MSUI", b"men", b"hello", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ea66b4b499bf1c864ed12323cc0eb83dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

