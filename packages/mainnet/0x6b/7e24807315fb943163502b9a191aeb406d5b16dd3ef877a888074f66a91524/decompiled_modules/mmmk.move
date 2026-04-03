module 0x6b7e24807315fb943163502b9a191aeb406d5b16dd3ef877a888074f66a91524::mmmk {
    struct MMMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMMK>(arg0, 6, b"MMMK", b"Rugs are Bad", b"Everyone knows rugs are bad, mmmk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1775245750784.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMMK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMMK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

