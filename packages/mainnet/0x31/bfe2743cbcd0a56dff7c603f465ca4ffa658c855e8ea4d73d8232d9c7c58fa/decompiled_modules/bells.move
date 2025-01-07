module 0x31bfe2743cbcd0a56dff7c603f465ca4ffa658c855e8ea4d73d8232d9c7c58fa::bells {
    struct BELLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELLS>(arg0, 9, b"BELLS", b"Bello616", b"Bell the bell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4a6c631-e86a-495a-bb4d-ff18b6afc7dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

