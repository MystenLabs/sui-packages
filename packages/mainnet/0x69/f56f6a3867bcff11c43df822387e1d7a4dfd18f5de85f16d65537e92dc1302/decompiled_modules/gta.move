module 0x69f56f6a3867bcff11c43df822387e1d7a4dfd18f5de85f16d65537e92dc1302::gta {
    struct GTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTA>(arg0, 9, b"GTA", b"Grant.", b"Fuck around and find out.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b49bb36d8e593ff610c798755360d0ffblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

