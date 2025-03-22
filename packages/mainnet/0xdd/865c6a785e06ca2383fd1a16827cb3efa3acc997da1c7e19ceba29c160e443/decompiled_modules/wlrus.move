module 0xdd865c6a785e06ca2383fd1a16827cb3efa3acc997da1c7e19ceba29c160e443::wlrus {
    struct WLRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLRUS>(arg0, 9, b"WLrus", b"WhaleRUS", b"all aboute big airdrops from this and you can believe this ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4502faf011e560626ba99701512db5c2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLRUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLRUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

