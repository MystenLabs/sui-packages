module 0xd0f62ed9eb6250f24fa7bf6f987bb4ea91c714f996c5825921ec76cc2e87264e::yen {
    struct YEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEN>(arg0, 9, b"YEN", b"YENNN", b"1YEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/956b1df8927991cef6cd61e2109711ebblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

