module 0x7d494d9082d657eab4cfc1a05bbc1cfecd003861c815d28ffd32a25d06353ab::geje {
    struct GEJE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEJE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEJE>(arg0, 9, b"GEJE", b"hejs", b"hanw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/447421ec-4be0-4d4e-ad5a-82c014c6fa03.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEJE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEJE>>(v1);
    }

    // decompiled from Move bytecode v6
}

