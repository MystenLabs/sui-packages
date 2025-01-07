module 0x8177b7eceda4854f4bb4aaf122b99dcc3ac94bcc98f300f3e2c95be8cc90b9ff::mst {
    struct MST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MST>(arg0, 6, b"Mst", b"Misty", b"Your decisions will decide Misty's destiny.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_VKZK_2_CI_400x400_1246212460.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MST>>(v1);
    }

    // decompiled from Move bytecode v6
}

