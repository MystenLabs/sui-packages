module 0x312a2accfd47d19c464309575fb5d4ad5ad6d4e405ff8beca61fa61f5684629c::mireh {
    struct MIREH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIREH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIREH>(arg0, 6, b"MIREH", b"Mikareh", b"Ereh where are you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/25e4f87ca9395804f18ba8cd02e948d1_aea846098c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIREH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIREH>>(v1);
    }

    // decompiled from Move bytecode v6
}

