module 0x6000a24e205ea82de2d62eb747b9798c48a96ee1dcc34b19430fa1ae0c8bb991::jhn {
    struct JHN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHN>(arg0, 9, b"JHN", b"Johnson ", b"A simple coin for unity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a541b5b-ba94-4a6c-8253-625ad9a39e73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JHN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JHN>>(v1);
    }

    // decompiled from Move bytecode v6
}

