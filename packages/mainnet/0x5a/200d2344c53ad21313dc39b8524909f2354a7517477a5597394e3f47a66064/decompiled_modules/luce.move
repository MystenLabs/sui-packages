module 0x5a200d2344c53ad21313dc39b8524909f2354a7517477a5597394e3f47a66064::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 9, b"LUCE", b"Luce", b"Official Mascot of the Holy Year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1429c305-1789-45c5-9b0c-1a41d9293633.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

