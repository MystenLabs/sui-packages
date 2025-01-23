module 0x214602adad8618fb260a335981c1f57c1f0474896c44ad48930e41a2f54fb62d::trumpmaga {
    struct TRUMPMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPMAGA>(arg0, 9, b"TRUMPMAGA", b"TRUMP", b"Trump token for trumpers ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90fd10f4-faca-49de-972f-0a6733354eda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

