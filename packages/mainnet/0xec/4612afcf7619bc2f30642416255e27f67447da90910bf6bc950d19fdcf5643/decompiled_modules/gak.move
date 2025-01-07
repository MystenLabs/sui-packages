module 0xec4612afcf7619bc2f30642416255e27f67447da90910bf6bc950d19fdcf5643::gak {
    struct GAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAK>(arg0, 9, b"GAK", b"gatau", b"gatau ini token apaan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f32089f1-0f5e-45bd-a378-c6dfd75965db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

