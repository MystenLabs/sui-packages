module 0x26e5c595c36589ddcf6806f4c2d7f0866a1c8b1885966728e3fe965e91fab430::nxcp {
    struct NXCP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NXCP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NXCP>(arg0, 6, b"NXCP", b"NYX CIPHER", b"Nyx Cipher is planning to launch its own token on SUI within 2 weeks from now. Stay tuned, more details are coming soon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_E_Gu_G0bl_400x400_4e20979558.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NXCP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NXCP>>(v1);
    }

    // decompiled from Move bytecode v6
}

