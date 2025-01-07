module 0x855bca03b8065a112beb151274c64844812121542fba3325fc53296ebc01b5e8::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE>(arg0, 9, b"SUICIDE", b"Suicid", b"Degen suicide token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b78dd7c-a5db-4b28-bdd0-a4972f1f95f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

