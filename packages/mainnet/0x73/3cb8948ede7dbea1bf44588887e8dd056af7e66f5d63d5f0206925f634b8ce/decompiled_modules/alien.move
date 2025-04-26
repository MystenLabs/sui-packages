module 0x733cb8948ede7dbea1bf44588887e8dd056af7e66f5d63d5f0206925f634b8ce::alien {
    struct ALIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIEN>(arg0, 9, b"ALIEN", b"aliensui", b"alien blue sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4b7f687c3ab03999a20ea90d9e45dd4ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALIEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

