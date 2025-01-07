module 0xc32a50739e8ab558d98d6822b74da032acda58b218f3a9fbf934545aca9e0e0a::jepe {
    struct JEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEPE>(arg0, 6, b"JEPE", b"JEPE on sui", x"746865206d6f7374206d656d6561626c65206a656c6c7966697368206f6e2074686520696e7465726e65740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mv1_F_j34_400x400_de8862a562.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

