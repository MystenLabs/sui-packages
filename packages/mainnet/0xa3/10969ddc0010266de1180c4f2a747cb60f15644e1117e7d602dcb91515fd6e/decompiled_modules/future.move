module 0xa310969ddc0010266de1180c4f2a747cb60f15644e1117e7d602dcb91515fd6e::future {
    struct FUTURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUTURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUTURE>(arg0, 9, b"FUTURE", b"Sui future", b"The future depends on you guys please give me the motivation to make more money ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/41cc2e44-a86f-4907-9f4d-1bcc230d5738.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUTURE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUTURE>>(v1);
    }

    // decompiled from Move bytecode v6
}

