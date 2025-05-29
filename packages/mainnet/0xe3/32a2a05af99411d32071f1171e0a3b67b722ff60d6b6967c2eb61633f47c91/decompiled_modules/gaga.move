module 0xe332a2a05af99411d32071f1171e0a3b67b722ff60d6b6967c2eb61633f47c91::gaga {
    struct GAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAGA>(arg0, 9, b"GAGA", b"Galaxy Games", b"Haunted Space is first AAA game within Galaxy Games ecosystem that concretely unites the world of traditional gaming and the blockchain, creating unique highly addictive gaming experiences to the game lovers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://galaxylab.gitbook.io/~gitbook/image?url=https%3A%2F%2F3491649214-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Fspaces%252FXbsaFanttzLImXeGVbYa%252Fuploads%252F8Z8CcXCQg5vrgOVGG6nR%252Fimage.png%3Falt%3Dmedia%26token%3D5df456aa-415b-48cf-b798-61cc93dffbe1&width=768&dpr=4&quality=100&sign=4a4e4712&sv=2")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GAGA>>(0x2::coin::mint<GAGA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GAGA>>(v2);
    }

    // decompiled from Move bytecode v6
}

