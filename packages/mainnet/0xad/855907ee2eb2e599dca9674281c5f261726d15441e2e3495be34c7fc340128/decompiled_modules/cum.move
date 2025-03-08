module 0xad855907ee2eb2e599dca9674281c5f261726d15441e2e3495be34c7fc340128::cum {
    struct CUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUM>(arg0, 9, b"CUM", b"North American union", b"The new union of north America ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b37fc90a3dce1863fab44d4e1a9f7d43blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

