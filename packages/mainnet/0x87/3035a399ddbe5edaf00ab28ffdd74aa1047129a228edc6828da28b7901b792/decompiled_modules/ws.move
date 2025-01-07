module 0x873035a399ddbe5edaf00ab28ffdd74aa1047129a228edc6828da28b7901b792::ws {
    struct WS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WS>(arg0, 9, b"WS", b"Wsui", b"The integration of wave and sui is a clear step for the future of sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27c1aef0-acb1-4953-b710-c0adca0afc0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WS>>(v1);
    }

    // decompiled from Move bytecode v6
}

