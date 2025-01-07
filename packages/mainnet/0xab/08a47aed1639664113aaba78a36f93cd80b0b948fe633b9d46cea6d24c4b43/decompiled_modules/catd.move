module 0xab08a47aed1639664113aaba78a36f93cd80b0b948fe633b9d46cea6d24c4b43::catd {
    struct CATD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATD>(arg0, 9, b"CATD", b"Catdun", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/77bb64ef-1eb2-4bb7-86ec-8bb53ec244f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATD>>(v1);
    }

    // decompiled from Move bytecode v6
}

