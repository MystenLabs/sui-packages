module 0x6b8f6e22ab2eb67689e897067050db62fe8ba0a970c28038ce71cbfba95a35b1::aoioi {
    struct AOIOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AOIOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOIOI>(arg0, 9, b"Aoioi", b"fgj", b"hai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/98c8b56be54e768f51e6be4e03cca3f7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AOIOI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOIOI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

