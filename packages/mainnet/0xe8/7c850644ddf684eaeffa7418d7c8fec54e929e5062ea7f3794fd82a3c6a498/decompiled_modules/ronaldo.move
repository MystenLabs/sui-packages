module 0xe87c850644ddf684eaeffa7418d7c8fec54e929e5062ea7f3794fd82a3c6a498::ronaldo {
    struct RONALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONALDO>(arg0, 6, b"Ronaldo", b"Ronaldo Coin", x"47657420726561647920666f722074686520756c74696d61746520676f616c207769746820526f6e616c646f20436f696e2c20746865206d656d6520636f696e20746861742063656c6562726174657320746865206c6567656e642068696d73656c662c20437269737469616e6f20526f6e616c646f21204578636c75736976656c79206f6e2074686520535549204e6574776f726b2c20526f6e616c646f20436f696e206272696e67732068697320756e73746f707061626c652073706972697420746f2074686520626c6f636b636861696e2e0a0a57687920526f6e616c646f20436f696e3f0a0a4c6567656e646172792056616c75653a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731921486232.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RONALDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONALDO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

