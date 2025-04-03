module 0xa7b3ae82d52f3b569fb12654fd35504dc3edc6321b1f7c6816d06bdf4decd919::pw {
    struct PW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PW>(arg0, 9, b"PW", b"President Walrus", b"King of the Hill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d84bf9527fa86e728812266f7e69cc8bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

