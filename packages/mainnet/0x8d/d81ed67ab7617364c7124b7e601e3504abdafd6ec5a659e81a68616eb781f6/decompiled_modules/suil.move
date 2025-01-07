module 0x8dd81ed67ab7617364c7124b7e601e3504abdafd6ec5a659e81a68616eb781f6::suil {
    struct SUIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIL>(arg0, 6, b"SUIL", b"SUILANA", b"Tribute to fun over utility. Next generation chains focused on Pumpility", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilana_d7ddb592d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

