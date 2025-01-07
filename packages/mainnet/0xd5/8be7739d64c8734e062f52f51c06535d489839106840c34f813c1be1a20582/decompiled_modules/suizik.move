module 0xd58be7739d64c8734e062f52f51c06535d489839106840c34f813c1be1a20582::suizik {
    struct SUIZIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZIK>(arg0, 6, b"SUIZIK", b"SUIZUKI", b"the best model of car for the best buyer of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_185057178_310ec7235b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

