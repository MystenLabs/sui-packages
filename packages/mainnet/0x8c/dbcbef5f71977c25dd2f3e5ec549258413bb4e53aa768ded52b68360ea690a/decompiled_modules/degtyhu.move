module 0x8cdbcbef5f71977c25dd2f3e5ec549258413bb4e53aa768ded52b68360ea690a::degtyhu {
    struct DEGTYHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGTYHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGTYHU>(arg0, 9, b"DEGTYHU", b"ghghkjtgh", b"bnhdgjy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc2bbf07-98da-449b-94dc-40048cf9bbff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGTYHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGTYHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

