module 0x4bfc9b871c1998753fcfca44444d98e71c27ff3b67bae7533510c5f21cf5fd01::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GME>(arg0, 9, b"GME", b"GMEonSui", b"Gme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9867365-27c9-46de-9a2b-1d419b99a3cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GME>>(v1);
    }

    // decompiled from Move bytecode v6
}

