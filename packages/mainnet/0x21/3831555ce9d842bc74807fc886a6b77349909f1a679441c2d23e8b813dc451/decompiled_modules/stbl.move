module 0x213831555ce9d842bc74807fc886a6b77349909f1a679441c2d23e8b813dc451::stbl {
    struct STBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STBL>(arg0, 9, b"STBL", b"super table", b"Super Table brown", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/13852d182b0a5a4ef94f75de5c22f9fdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

