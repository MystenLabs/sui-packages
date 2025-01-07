module 0x187c632d02a7f199792306f86ca3686b6a9327ec0d07554423a66fa200364caf::crkn {
    struct CRKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRKN>(arg0, 9, b"CRKN", b"Cracken", b"Ocean giant octopas new era of ocean king meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a89a283-8803-4809-b805-19bda44a2652.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

