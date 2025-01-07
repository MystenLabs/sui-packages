module 0x434a95c3def6e8f8ebdbaadff981f508fc345e796fcea3a660d554b8a3ba9210::wwgl {
    struct WWGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWGL>(arg0, 9, b"WWGL", b"WeWeGombeL", b"WeWeGombeL is another off meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/037f1bbe-a415-4af9-af2d-0136cdcfb55e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

