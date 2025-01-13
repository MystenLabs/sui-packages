module 0xea57ed8a03b5835a4d43623fe1fc6379394ffa08bf71b74f19f692433a59fc25::dgm {
    struct DGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DGM>(arg0, 6, b"DGM", b"DOGMAN by SuiAI", b"DOG MAN with artificial intelligence and developed fighting spirit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/8b_ZE_7_T6_M_400x400_2939a615c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DGM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

