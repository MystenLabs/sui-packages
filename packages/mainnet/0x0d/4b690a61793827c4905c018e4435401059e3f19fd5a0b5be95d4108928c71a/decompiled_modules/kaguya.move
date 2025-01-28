module 0xd4b690a61793827c4905c018e4435401059e3f19fd5a0b5be95d4108928c71a::kaguya {
    struct KAGUYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAGUYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAGUYA>(arg0, 6, b"KAGUYA", b"kaguya.app", x"4b61677579612069732061206d756c74692d6c616e677561676520706c6174666f726d206f66666572696e6720616e696d652c206d616e67612c20616e642072656c61746564207265736f757263657320706f776572656420627920244b41475559412e0a0a4578706c6f726520796f7572206661766f7269746520616e696d6520616e64206d616e67612c2075706461746520796f757220416e696c6973742077697468206e657720656e74726965732c20616e6420706172746963697061746520696e207761746368207061727469657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_031709_793_8baed8896e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAGUYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAGUYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

