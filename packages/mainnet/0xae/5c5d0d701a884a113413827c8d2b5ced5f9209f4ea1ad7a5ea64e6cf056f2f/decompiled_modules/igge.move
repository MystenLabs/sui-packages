module 0xae5c5d0d701a884a113413827c8d2b5ced5f9209f4ea1ad7a5ea64e6cf056f2f::igge {
    struct IGGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGGE>(arg0, 6, b"IGGE", b"Mother IGGE", x"57686f204461742c2057686f204461743f204d6f74686572204967676520417a616c6561206973206f6e205355492e204272696e67696e672074686520436f6d6d756e697479206f6620446567656e7320746f676574686572207468726f7567682074686520506f776572206f6620426f6f74792c20476f6f6420566962657320616e6420536c6179696e67204368617274732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y1o4t8yu_400x400_496f64c309.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IGGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

