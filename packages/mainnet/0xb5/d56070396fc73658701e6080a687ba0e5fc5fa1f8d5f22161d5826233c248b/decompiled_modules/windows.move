module 0xb5d56070396fc73658701e6080a687ba0e5fc5fa1f8d5f22161d5826233c248b::windows {
    struct WINDOWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINDOWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINDOWS>(arg0, 6, b"WINDOWS", b"Windows on Sui", b"First Windows on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bdogbg_ec2db3e594.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINDOWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINDOWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

