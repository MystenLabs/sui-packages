module 0x65bffaf25362f88b3a212ded5e6d758ea077a8db05b0bf5cf99482726a55b603::suiante69 {
    struct SUIANTE69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIANTE69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIANTE69>(arg0, 6, b"SUIANTE69", b"Suitel Core i69", x"3639204d206b4b4b4b4b4b4b4b4b656b652c20416f732049656e206170204936392d3432303030305858582043706565464646464646467520746f6f20362c363647687a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1294195jcreqdfj919jfj91923_28705d12ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIANTE69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIANTE69>>(v1);
    }

    // decompiled from Move bytecode v6
}

