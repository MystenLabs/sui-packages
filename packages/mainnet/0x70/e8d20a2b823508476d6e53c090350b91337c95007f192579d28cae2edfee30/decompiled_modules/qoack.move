module 0x70e8d20a2b823508476d6e53c090350b91337c95007f192579d28cae2edfee30::qoack {
    struct QOACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QOACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QOACK>(arg0, 6, b"QOACK", b"CAPTAIN QOACK", b"QOACK is a degenerate duck gambler with a Captain qoack for trouble on the blockchain network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730971703939.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QOACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QOACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

