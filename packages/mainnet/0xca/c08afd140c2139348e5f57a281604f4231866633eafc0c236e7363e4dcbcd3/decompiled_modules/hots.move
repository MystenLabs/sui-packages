module 0xcac08afd140c2139348e5f57a281604f4231866633eafc0c236e7363e4dcbcd3::hots {
    struct HOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTS>(arg0, 9, b"HOTS", b"HOT ", b"HOT FUTURE PLAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5b8c90f-9bad-4c88-8673-e502728c1c6b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

