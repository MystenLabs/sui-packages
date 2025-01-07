module 0x7f9b35b64eebc033bbd4b930aeb0c47fb4fcc9240dd1a4e0fe116896464b119c::suibao {
    struct SUIBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAO>(arg0, 6, b"SUIBAO", b"Char Sui Bao", b"A Delicious CHAR SUI BAO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIBAO_d426016493.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

