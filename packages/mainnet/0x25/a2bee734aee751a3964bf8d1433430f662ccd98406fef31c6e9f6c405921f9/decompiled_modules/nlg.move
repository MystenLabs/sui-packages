module 0x25a2bee734aee751a3964bf8d1433430f662ccd98406fef31c6e9f6c405921f9::nlg {
    struct NLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLG>(arg0, 9, b"NLG", b"nailong", b"smile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1e17b83-48a1-404a-aa13-56113056c3d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

