module 0xe83bfc0531bd7948df0842dca656a07dd914c41e3007cc8b73775237c6658eb8::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"Meow", b"Meow Money On Sui", x"4e6f207370616d3a20446f206e6f7420706f7374206164766572746973696e672c207370616d206f7220756e72656c6174656420636f6e74656e7420746f207468652067726f7570277320746f7069632e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_02_04_23_00_13_bc2c4d54e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

