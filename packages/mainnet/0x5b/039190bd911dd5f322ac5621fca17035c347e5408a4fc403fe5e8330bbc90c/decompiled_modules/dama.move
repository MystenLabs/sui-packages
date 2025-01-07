module 0x5b039190bd911dd5f322ac5621fca17035c347e5408a4fc403fe5e8330bbc90c::dama {
    struct DAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAMA>(arg0, 6, b"DAMA", b"GENKI", b"HARO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731337083272.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

