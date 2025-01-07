module 0x235e0f55c2ae3e080ac7a6bc93df6176df61d26808941e24bf642ae26258edb7::elga {
    struct ELGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELGA>(arg0, 9, b"ELGA", b"ELONGATE", b"Collaboration between Elon Musk and Bill Gate brings us crypto success..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6063249b-7893-4344-834f-44077c96ae9d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

