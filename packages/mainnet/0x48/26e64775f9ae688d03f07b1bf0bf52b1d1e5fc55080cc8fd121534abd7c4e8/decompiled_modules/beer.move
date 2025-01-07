module 0x4826e64775f9ae688d03f07b1bf0bf52b1d1e5fc55080cc8fd121534abd7c4e8::beer {
    struct BEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEER>(arg0, 9, b"BEER", x"4265657220f09f8dba20", b"Best serve cold ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0b723eb-7153-4e39-a80c-8454c67522b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

