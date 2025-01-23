module 0x9310068be580484fcd072db09c140495145a79342f2a35e44344130c263e5ab::ivanka {
    struct IVANKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVANKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IVANKA>(arg0, 6, b"IVANKA", b"IVANKA by SuiAI", b"Ivanka on SUI. SHOW HER SUI MEANS BUSINESS!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/i5_Z_Xf_Fd_E_400x400_f4558f641e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IVANKA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVANKA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

