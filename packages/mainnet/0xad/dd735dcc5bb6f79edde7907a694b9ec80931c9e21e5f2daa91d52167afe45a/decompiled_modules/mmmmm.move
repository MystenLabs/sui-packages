module 0xaddd735dcc5bb6f79edde7907a694b9ec80931c9e21e5f2daa91d52167afe45a::mmmmm {
    struct MMMMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMMMM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742372199821.jfif"));
        let (v1, v2) = 0x2::coin::create_currency<MMMMM>(arg0, 6, b"mmmm", b"mmmmm", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMMMM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMMMM>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MMMMM>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MMMMM>>(arg0);
    }

    // decompiled from Move bytecode v6
}

