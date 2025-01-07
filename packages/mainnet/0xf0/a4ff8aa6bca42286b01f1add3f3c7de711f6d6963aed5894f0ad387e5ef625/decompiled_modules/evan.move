module 0xf0a4ff8aa6bca42286b01f1add3f3c7de711f6d6963aed5894f0ad387e5ef625::evan {
    struct EVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVAN>(arg0, 6, b"EVAN", b"Evan The Hobo On Sui", b"First Evan The Hobo On Sui: evanthehobocoin.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/673ce809ffd4f8ace91f5c21_Click_this_p_1600_c8f75be17a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

