module 0xb7a359031b7badd6d844be4a1c781d4dcc54bd87b661c0c430fbcacaaf6fc9e::laugh {
    struct LAUGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAUGH>(arg0, 6, b"LAUGH", b"LaughCoin", b" LaughCoin est conu pour clbrer lhumour et les rires. Chaque token reprsente un moment de joie et de bonne humeur, parfait pour ceux qui aiment les blagues et les mmes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Laughcoin_113e159ba0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAUGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

