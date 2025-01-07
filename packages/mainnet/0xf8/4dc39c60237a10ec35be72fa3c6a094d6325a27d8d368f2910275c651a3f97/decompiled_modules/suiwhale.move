module 0xf84dc39c60237a10ec35be72fa3c6a094d6325a27d8d368f2910275c651a3f97::suiwhale {
    struct SUIWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWHALE>(arg0, 6, b"SUIWHALE", b"Suiwhale", b"Whales dominate the ocean with their enormous strength and size, symbols of unshakable authority.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_No_x_T_Wg_A_Ay_J_Rc_da8b13f28b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

