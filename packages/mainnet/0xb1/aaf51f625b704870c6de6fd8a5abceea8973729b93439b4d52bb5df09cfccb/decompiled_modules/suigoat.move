module 0xb1aaf51f625b704870c6de6fd8a5abceea8973729b93439b4d52bb5df09cfccb::suigoat {
    struct SUIGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOAT>(arg0, 6, b"SUIGOAT", b"GOAT WIF HAT", x"5768617420646f657320746865206861742073796d626f6c697a653f0a49742073796d626f6c697a6573206265696e67206f6e636861696e20616e64206265696e672070617274206f66206f7572206d6f76656d656e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_28_at_10_33_49a_pm_77dba7313b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

