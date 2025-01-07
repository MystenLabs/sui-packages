module 0x11e211427eef272eb1f0242544bb5f3ba902b98ba9317f18accd4ba8221c1d63::garinmu {
    struct GARINMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARINMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARINMU>(arg0, 9, b"GARINMU", b"GIADE", b"A token created for monumental and historic moment in my life associate with my lineage.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5e76dfc-052f-4ed2-8f91-3ed7437eaa20.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARINMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GARINMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

