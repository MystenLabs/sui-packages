module 0xc1cbbb10e9a1e84fa32c8f0f99403c4a98f82d975c7c3c1f6ecbdab2f9b13987::doom {
    struct DOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOM>(arg0, 6, b"Doom", b"Sui Doom", x"24446f6f6d206973206865726520616e6420686973206d697373696f6e20697320746f20756e6c65617368206368616f7320696e207468652053756920736561210a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Doom_profile_move_1_742b0df114.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

