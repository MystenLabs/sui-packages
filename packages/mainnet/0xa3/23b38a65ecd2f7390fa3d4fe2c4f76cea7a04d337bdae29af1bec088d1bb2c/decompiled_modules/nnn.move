module 0xa323b38a65ecd2f7390fa3d4fe2c4f76cea7a04d337bdae29af1bec088d1bb2c::nnn {
    struct NNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNN>(arg0, 6, b"NNN", b"NNN", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNN>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NNN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

