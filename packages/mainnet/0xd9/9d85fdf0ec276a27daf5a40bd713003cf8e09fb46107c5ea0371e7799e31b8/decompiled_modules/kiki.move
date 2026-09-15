module 0xd99d85fdf0ec276a27daf5a40bd713003cf8e09fb46107c5ea0371e7799e31b8::kiki {
    struct KIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<KIKI>(arg0, 6, 0x1::string::utf8(b"KIKI"), 0x1::string::utf8(b"kiki"), 0x1::string::utf8(x"4e6f626f6479206b6e6f777320776879204b696b69206578697374732e204e6f626f6479206b6e6f7773207768657265204b696b692063616d652066726f6d2e0a0a416c6c207765206b6e6f772069732074686174204b696b692068617320617272697665642c20616e642074686520696e7465726e65742077696c6c206e65766572206265207468652073616d652e0a0a4a7573742076696265732e204a757374206d656d65732e204a757374204b696b692e"), 0x1::string::utf8(b"https://popularsui.xyz/media/0f64ab6442b8c5f0bc67ef45c5078c67d9557d82841dec59a3278a8ea342d79c.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<KIKI>>(0x2::coin_registry::finalize<KIKI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

