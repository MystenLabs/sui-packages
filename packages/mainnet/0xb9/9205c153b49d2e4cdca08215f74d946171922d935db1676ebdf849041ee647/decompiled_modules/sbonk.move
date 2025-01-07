module 0xb99205c153b49d2e4cdca08215f74d946171922d935db1676ebdf849041ee647::sbonk {
    struct SBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBONK>(arg0, 6, b"SBONK", b"BonkSui", b"Bonk on sui is the next Powerful Token on the Market. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732018386566.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBONK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBONK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

