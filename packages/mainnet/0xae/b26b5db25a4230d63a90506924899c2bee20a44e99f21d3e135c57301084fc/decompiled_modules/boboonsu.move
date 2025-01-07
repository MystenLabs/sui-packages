module 0xaeb26b5db25a4230d63a90506924899c2bee20a44e99f21d3e135c57301084fc::boboonsu {
    struct BOBOONSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBOONSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBOONSU>(arg0, 9, b"BOBOONSU", b"BoBo Me", b"BoBo is BoBo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c494fb35-46db-4912-ae71-750fa770c0bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBOONSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBOONSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

