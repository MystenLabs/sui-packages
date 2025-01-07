module 0xa6f2f8a4cdc419a580fe7afc89187723ddb24fbdad247b313e6b42fb06ea6dff::doni {
    struct DONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONI>(arg0, 9, b"DONI", b"Doni kong", b"Donikong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d70d5cc-f8f7-457d-98d2-1442513b23ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

