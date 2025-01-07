module 0xbb79cb91c5096d39a20b25c51a2d6c6120b317d3b915b3bd5bfc7e782d5ad669::one {
    struct ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE>(arg0, 6, b"ONE", b"OneSUI", x"4f6e655375692028244f4e4529202d2054686520736f6369616c206578706572696d656e742077686572652065766572796f6e6520686f6c64732065786163746c792031205355492e200a4e6f206d6f72652c206e6f206c6573732e205065726665637420657175616c697479206f6e2074686520626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ONE_d429c301d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

