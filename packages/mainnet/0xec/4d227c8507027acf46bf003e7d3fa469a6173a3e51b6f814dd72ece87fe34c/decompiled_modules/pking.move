module 0xec4d227c8507027acf46bf003e7d3fa469a6173a3e51b6f814dd72ece87fe34c::pking {
    struct PKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKING>(arg0, 9, b"PKing", b"Pepeking", b"Make by PepeKing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e9c33cd37d0e95ae47b0e4cf16117aa2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

