module 0x6d3de0e63e1770fd3f7096898b5d540ad2bad87f26ed4497cd786ed98ae4239f::qqq77 {
    struct QQQ77 has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQQ77, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQQ77>(arg0, 9, b"QQQ77", b"QQQ77777", b"I like being with you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ae0a6c40b8addc907d52b42bebb3a4b8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QQQ77>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQQ77>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

