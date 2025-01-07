module 0xb81a40a657e6d9a4511c4f195dcf4b6f6a66277fcfd1bdb62423fa623ddc1d6::dao {
    struct DAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAO>(arg0, 9, b"DAO", b"Cham", b"Nitini", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18fb2c61-5984-44e4-a596-12d2f569df2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

