module 0xcbb2a3c3113f0ae55ddbfe42aef32ea5fb52fa96d091d6d5b437a42518dd72ab::senpai_123 {
    struct SENPAI_123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENPAI_123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENPAI_123>(arg0, 9, b"SENPAI_123", b"mafia", b"learn to Win from a failure, move forward and conquer with the mafia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4fc26f83-c70e-49d1-b48e-5bfad594cb75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENPAI_123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SENPAI_123>>(v1);
    }

    // decompiled from Move bytecode v6
}

