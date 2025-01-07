module 0xd0002aa8c624540798e7e53daa3058916c7b683126dadc7d2339baff51595c2::bonk {
    struct BONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONK>(arg0, 6, b"BONK", b"BONK on sui", b"Bonk: When you realize your blockchain is smoother than your dance moves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bonksui_395e687ec0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

