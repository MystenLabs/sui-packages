module 0xea9c1c3ce0543e0f5e95fa3c619ad4392a15696a335f0223e0f2f0905d7f92de::womy {
    struct WOMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOMY>(arg0, 6, b"WOMY", b"Womy on Sui", b"$WOMY king of the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/womy_67fbd31e9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

