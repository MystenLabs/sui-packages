module 0x5129412762f5328beaa32134e845a339146e81add7e70aff6341f8c0dc738562::k7r {
    struct K7R has drop {
        dummy_field: bool,
    }

    fun init(arg0: K7R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K7R>(arg0, 9, b"K7R", b"yiul", b"fyilu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/dd768a174cc592b32111d50121e6978bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K7R>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K7R>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

