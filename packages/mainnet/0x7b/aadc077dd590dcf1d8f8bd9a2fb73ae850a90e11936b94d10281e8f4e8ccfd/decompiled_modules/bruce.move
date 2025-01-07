module 0x7baadc077dd590dcf1d8f8bd9a2fb73ae850a90e11936b94d10281e8f4e8ccfd::bruce {
    struct BRUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUCE>(arg0, 6, b"BRUCE", b"Bruce The Shark", b"He's always angry. Can he find happiness in the SUI universe?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bruce_Profile_Pic_e9f56bc54d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

