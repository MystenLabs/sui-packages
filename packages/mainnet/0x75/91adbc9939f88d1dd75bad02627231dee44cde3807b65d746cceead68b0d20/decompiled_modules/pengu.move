module 0x7591adbc9939f88d1dd75bad02627231dee44cde3807b65d746cceead68b0d20::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 9, b"Pengu", b"pengu sui", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e7f3987a14281ab9582fa11739bc59eeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

