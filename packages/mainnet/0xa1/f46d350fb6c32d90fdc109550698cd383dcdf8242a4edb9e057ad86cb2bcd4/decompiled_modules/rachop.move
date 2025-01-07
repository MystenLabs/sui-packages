module 0xa1f46d350fb6c32d90fdc109550698cd383dcdf8242a4edb9e057ad86cb2bcd4::rachop {
    struct RACHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACHOP>(arg0, 6, b"RACHOP", b"RachopOnSui", x"24524143484f50202d2066697273742070726f6a656374732077696c6c20626520616e20696e6372656469626c6520657870657269656e636520666f72207573210a576520696e766974652065766572796f6e6520746f206a6f696e207573206f6e2074686973206e657720616476656e74757265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_031806_62911864b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

