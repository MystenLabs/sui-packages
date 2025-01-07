module 0x4dc5c9777488671e9837400573e7b698bb42991dcd623fbe22b6fc74433e30d3::hopfish {
    struct HOPFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFISH>(arg0, 6, b"HOPFISH", b"HopFish", b"They say fish don't jump, I'm an exception.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GYRE_FIWAAA_4_Ke_Q_81268b78f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

