module 0xf1875211e668b7ca4cbc84d867cc26c8a6a9df85d8a145ca6ed1f762d3bf76e2::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"Suiper Ai", b"Just For fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/0_4n_S2_Vat_BX_rlg_VZJ_40c2e75f03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

