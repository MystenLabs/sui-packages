module 0x3c034b34b88cec07056ce974becc25665b764c4cdc105f45155ba0def5ca7cc3::ws {
    struct WS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WS>(arg0, 9, b"WS", b"WALSUI", b"token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4ad8c7c9086d2507ec7ce7eb58715cc1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

