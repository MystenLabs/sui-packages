module 0x9055206efba5fd3605463f4e09fdb9abcc5a41c46627da0645093025488a1943::nurr {
    struct NURR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NURR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NURR>(arg0, 9, b"NURR", b"Nura", b"Nurrtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1827a6be-47de-4762-bc8b-d7f47723a7d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NURR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NURR>>(v1);
    }

    // decompiled from Move bytecode v6
}

