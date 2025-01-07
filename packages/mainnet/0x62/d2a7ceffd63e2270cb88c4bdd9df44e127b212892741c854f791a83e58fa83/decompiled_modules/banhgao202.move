module 0x62d2a7ceffd63e2270cb88c4bdd9df44e127b212892741c854f791a83e58fa83::banhgao202 {
    struct BANHGAO202 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANHGAO202, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANHGAO202>(arg0, 9, b"BANHGAO202", b"Banhgao", b"Rice cake is a product I created for my beloved daughter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5dd5c15f-e71b-406b-bb55-517aba753ec1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANHGAO202>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANHGAO202>>(v1);
    }

    // decompiled from Move bytecode v6
}

