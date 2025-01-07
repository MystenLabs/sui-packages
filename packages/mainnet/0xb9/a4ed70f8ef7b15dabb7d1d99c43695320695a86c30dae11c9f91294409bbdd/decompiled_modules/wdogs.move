module 0xb9a4ed70f8ef7b15dabb7d1d99c43695320695a86c30dae11c9f91294409bbdd::wdogs {
    struct WDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOGS>(arg0, 9, b"WDOGS", b"WORK DOGS", b"Telegram Original MeMe Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31847db6-8f1f-4272-ac10-c012520fa50d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

