module 0x10fe79d0462a97c373e0760cd16cc74d305d7cbe22c41134c1c95decddf74824::rockygoon {
    struct ROCKYGOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKYGOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKYGOON>(arg0, 9, b"ROCKYGOON", b"RGN", b"RGN is token multimedia ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/631f756c-63f9-4117-9806-a25b50f3aaaa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKYGOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCKYGOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

