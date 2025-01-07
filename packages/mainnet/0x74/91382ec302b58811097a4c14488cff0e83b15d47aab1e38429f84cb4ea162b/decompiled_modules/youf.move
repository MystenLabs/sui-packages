module 0x7491382ec302b58811097a4c14488cff0e83b15d47aab1e38429f84cb4ea162b::youf {
    struct YOUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOUF>(arg0, 9, b"YOUF", b"Foryou", b"Youf trading wewe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea689aee-49ad-4a0c-adc0-62ec02a29652.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

