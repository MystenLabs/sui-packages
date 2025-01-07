module 0x57011affde83c1d58ea2fdba2b040f8b8d8b67c61678bf3d687382e627854d1c::dragon {
    struct DRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGON>(arg0, 6, b"DRAGON", b"SUIDRAGON", x"496d2074686520447261676f6e206f6e205375692e2052415757575757575252522e200a5468697320697320746865206f726967696e616c2070726f6a6563742e20446f6e6074206265207363616d6d656421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Q_Ed_VTR_7_V_400x400_a23a25bf97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

