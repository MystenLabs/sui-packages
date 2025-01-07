module 0x6b28ee2281bfccc63eb455d2ab8b599555901e2f10fbb6bae26f5d8e7b99c4eb::snd {
    struct SND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SND>(arg0, 9, b"SND", b"Snopdy", b"Token for community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9cc271ab-dec2-484d-8875-3b085ebf8aa3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SND>>(v1);
    }

    // decompiled from Move bytecode v6
}

