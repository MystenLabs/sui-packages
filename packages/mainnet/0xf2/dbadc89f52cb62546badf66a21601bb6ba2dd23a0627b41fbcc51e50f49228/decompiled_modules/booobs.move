module 0xf2dbadc89f52cb62546badf66a21601bb6ba2dd23a0627b41fbcc51e50f49228::booobs {
    struct BOOOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOOBS>(arg0, 9, b"BOOOBS", b"BOOBS", b"Just boobs and fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a19de5345ab35d1cb834b1399c39e7bfblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOOBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOOBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

