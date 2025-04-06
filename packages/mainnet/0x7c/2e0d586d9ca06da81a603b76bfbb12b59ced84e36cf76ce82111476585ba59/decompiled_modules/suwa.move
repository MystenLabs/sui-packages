module 0x7c2e0d586d9ca06da81a603b76bfbb12b59ced84e36cf76ce82111476585ba59::suwa {
    struct SUWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWA>(arg0, 9, b"SUWA", b"SUIWAL", b"SUI X WALRUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/84b4e9d225f0c7dff567468c497c281eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUWA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

