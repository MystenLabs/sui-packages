module 0x861902e85cade414f067a29f732d551c65fe3dc30fdb19db592b95aca99e2ac8::teeblaq {
    struct TEEBLAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEEBLAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEEBLAQ>(arg0, 9, b"TEEBLAQ", b"TEE BLAQ ", b"A general multipurpose meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4a841a4-37c4-412d-b099-a383583e551b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEEBLAQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEEBLAQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

