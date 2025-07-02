module 0x7dd09847eab94709d915f07d3815f6eb8b24468702fb6605dbbbd07b8906d1::gta {
    struct GTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTA>(arg0, 6, b"GTA", b"GTA6", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GTA>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GTA>>(v2);
    }

    // decompiled from Move bytecode v6
}

