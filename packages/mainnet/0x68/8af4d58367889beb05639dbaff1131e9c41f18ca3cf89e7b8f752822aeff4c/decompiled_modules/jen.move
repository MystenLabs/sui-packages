module 0x688af4d58367889beb05639dbaff1131e9c41f18ca3cf89e7b8f752822aeff4c::jen {
    struct JEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEN>(arg0, 9, b"JEN", b"Jennie", b"dhdfhf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9e8e0ad12f1d7beff8a7958502a00961blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

