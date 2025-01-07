module 0xfc36a3ca0dfda90aee15e0de65321c7c005a9ed71551ac87079b9bd0f5a03019::suq {
    struct SUQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUQ>(arg0, 6, b"SUQ", b"Suq Inu", x"53555120697320746865206f6666696369616c20636f6d6d756e697479206d656d6520636f696e206f6e20696e6372656469626c652053756920636861696e2e200a0a426577617265206f66207363616d7320616e64206b696e646c7920766572696679206f75722061757468656e746963697479207468726f756768206f7572206f6666696369616c20776562736974652c207477697474657220616e642074656c656772616d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/warren_smith_649f094dd8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

