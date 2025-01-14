module 0xd33bbfd4ab7eee7957f421d5e09deecf895bd4bfcc35c40835f052e73c742957::sakamoto {
    struct SAKAMOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKAMOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKAMOTO>(arg0, 6, b"Sakamoto", b"Sui Sakamoto", x"57656c636f6d65205461726f2053616b616d6f746f20746f20537569204e6574776f726b2120517569657420737472656e677468206d65657473207365616d6c65737320706f776572e280946275696c64696e672061207365637572652c20756e73746f707061626c652066757475726520746f6765746865722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736883198161.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAKAMOTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKAMOTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

