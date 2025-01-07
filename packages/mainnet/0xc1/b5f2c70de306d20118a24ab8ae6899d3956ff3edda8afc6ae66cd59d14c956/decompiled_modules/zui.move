module 0xc1b5f2c70de306d20118a24ab8ae6899d3956ff3edda8afc6ae66cd59d14c956::zui {
    struct ZUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUI>(arg0, 6, b"ZUI", b"zzzui", b"zzzui on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdvasv1q_e7ea11f6b2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

