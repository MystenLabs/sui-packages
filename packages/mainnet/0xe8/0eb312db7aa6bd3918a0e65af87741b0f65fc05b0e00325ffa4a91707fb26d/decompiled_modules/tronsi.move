module 0xe80eb312db7aa6bd3918a0e65af87741b0f65fc05b0e00325ffa4a91707fb26d::tronsi {
    struct TRONSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRONSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRONSI>(arg0, 9, b"TRONSI", b"TRON SUI NETWORK", b"Buy this tron x sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7c9c2fadbf7b32a86246c0ecb7ce6ebeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRONSI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRONSI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

