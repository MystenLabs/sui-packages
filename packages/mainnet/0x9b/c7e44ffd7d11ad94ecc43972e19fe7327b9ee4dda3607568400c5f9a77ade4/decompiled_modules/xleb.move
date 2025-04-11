module 0x9bc7e44ffd7d11ad94ecc43972e19fe7327b9ee4dda3607568400c5f9a77ade4::xleb {
    struct XLEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: XLEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XLEB>(arg0, 9, b"XLEB", b"Xlebushek", b"The xleb!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b40ae1ee37fb5421990e6ddb0138254ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XLEB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XLEB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

