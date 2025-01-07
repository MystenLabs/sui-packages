module 0x43a400f13504f6dc6b3694ed8e5fe79cd55372e4b09795b696f12d88b731cea4::bully {
    struct BULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLY>(arg0, 6, b"BULLY", b"BULLY on sui", b"meet bully on the sui waters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_12_1bc25b5bfa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

