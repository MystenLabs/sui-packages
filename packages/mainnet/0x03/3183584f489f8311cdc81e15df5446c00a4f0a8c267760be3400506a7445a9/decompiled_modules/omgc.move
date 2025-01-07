module 0x33183584f489f8311cdc81e15df5446c00a4f0a8c267760be3400506a7445a9::omgc {
    struct OMGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMGC>(arg0, 9, b"OMGC", b"OIMAIGOT", b"oivaicalon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac511f76-2e9a-4d10-a82f-3e5245eaab33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

