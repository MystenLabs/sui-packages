module 0x14cf81afee7a8c0fade5935713f89b6f4c7b1aeea3a7ad6d24c2a5ad00a8df0e::muiut {
    struct MUIUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUIUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUIUT>(arg0, 6, b"MUIUT", b"MUIU", b"HE IS HERE TO MUI YOU , made with ROMANIAN BLOOD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732547968308.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUIUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUIUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

