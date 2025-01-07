module 0xeb0abdebc9325afa90742b6a10f3e4d42f72b039be6e9f75972359a9131b5b5e::bpepe {
    struct BPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPEPE>(arg0, 6, b"BPEPE", b"BLUE PEPE", x"54686520756c74696d617465206d656d652066726f67206a7573742077656e742066756c6c20646567656e2c206e6f7720726f636b696e6720746861742069637920626c75652064726970206f6e205375692e20746869732061696e7420796f757220726567756c617220506570652c2069747320426c756520506570650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/strong_snek_68fecb6499b5810d8d61_3cabc3195d_9f678b37c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

