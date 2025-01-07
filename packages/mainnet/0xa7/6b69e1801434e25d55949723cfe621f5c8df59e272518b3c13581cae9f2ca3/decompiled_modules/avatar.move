module 0xa76b69e1801434e25d55949723cfe621f5c8df59e272518b3c13581cae9f2ca3::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVATAR>(arg0, 6, b"AVATAR", b"AVATARSUI", x"415641544152535549204f4e20484953205741590a546865206c6173742061697262656e64657220696e207468652063727970746f20776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000196889_a388bb9a84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVATAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVATAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

