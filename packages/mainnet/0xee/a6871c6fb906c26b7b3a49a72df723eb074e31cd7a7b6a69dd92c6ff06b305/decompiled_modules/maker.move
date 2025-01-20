module 0xeea6871c6fb906c26b7b3a49a72df723eb074e31cd7a7b6a69dd92c6ff06b305::maker {
    struct MAKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAKER>(arg0, 6, b"MAKER", b"Sui Maker", x"5355494d414b45523a204574686963616c204d61726b6574204d616b657220536f6c7574696f6e73202620437573746f6d2047505420536572766963657320666f7220746865205375692045636f73797374656d0a5265766f6c7574696f6e697a6520426c6f636b636861696e20616e642041492077697468205375694d616b65720a5375694d616b6572206973207472616e73666f726d696e67207468652053756920626c6f636b636861696e207769746820696e6e6f766174697665206d61726b65742d6d616b696e6720736f6c7574696f6e7320616e6420637573746f6d204750542d706f776572656420414920617070732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_025315_007_d2a783920c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

