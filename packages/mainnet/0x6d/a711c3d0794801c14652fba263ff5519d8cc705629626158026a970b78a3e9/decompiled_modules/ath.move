module 0x6da711c3d0794801c14652fba263ff5519d8cc705629626158026a970b78a3e9::ath {
    struct ATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATH>(arg0, 8, b"ATH", b"Athena", b"Athena Weapons", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/J1Tsnvj.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ATH>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

