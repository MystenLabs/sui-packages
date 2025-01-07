module 0x4362105de2d05cbd2780117c239376157bc3dda006ab751151740557e1c20328::mr {
    struct MR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MR>(arg0, 9, b"MR", b"Murakata", b"Good token meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9860d01-bf49-4691-85e9-f149170f7bbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MR>>(v1);
    }

    // decompiled from Move bytecode v6
}

