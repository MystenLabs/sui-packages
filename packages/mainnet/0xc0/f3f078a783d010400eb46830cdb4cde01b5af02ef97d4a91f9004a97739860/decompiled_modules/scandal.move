module 0xc0f3f078a783d010400eb46830cdb4cde01b5af02ef97d4a91f9004a97739860::scandal {
    struct SCANDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCANDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCANDAL>(arg0, 6, b"SCANDAL", b"SCANDAL SUI", b"you won't be shit, you wan't be SCANDAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730961968315.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCANDAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCANDAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

