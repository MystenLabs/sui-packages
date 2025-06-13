module 0x609aa94895d760956d92dc363326b4aa60f2707e7a73988ba08da1f374aada8e::wwt {
    struct WWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWT>(arg0, 9, b"WWT", b"WarriorWenchToken", b"sui token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/62abb489001327fb694ee08652a43060blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

