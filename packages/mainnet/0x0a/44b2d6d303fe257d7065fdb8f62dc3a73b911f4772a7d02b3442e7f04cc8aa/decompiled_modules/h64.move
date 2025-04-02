module 0xa44b2d6d303fe257d7065fdb8f62dc3a73b911f4772a7d02b3442e7f04cc8aa::h64 {
    struct H64 has drop {
        dummy_field: bool,
    }

    fun init(arg0: H64, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H64>(arg0, 9, b"H64", b"w546", b"dyuo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3e5e3541e59404e436da46a46be98f2eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<H64>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H64>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

