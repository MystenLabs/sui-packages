module 0x31548647d1b08019fd2952465ee553a86f2f6948890e38bd078e747e699f9215::rick {
    struct RICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICK>(arg0, 9, b"RICK", b"Rick coin", b"Rick c-137", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ba89212-ac04-4fb8-9724-02973c533c33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

