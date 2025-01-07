module 0x30dd1edaf583d51fbe65fb4cd8d6a750c0e2e86f73977a62f4c73a3d28add145::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"BLUE", b"Blue Pepe", x"54686520756c74696d617465206d656d652066726f67206a7573742077656e742066756c6c20646567656e2c206e6f7720726f636b696e6720746861742069637920626c75652064726970206f6e205375692e20746869732061696e7420796f757220726567756c617220506570652c2069747320426c756520506570650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/bluepepe_1b55cea10d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

