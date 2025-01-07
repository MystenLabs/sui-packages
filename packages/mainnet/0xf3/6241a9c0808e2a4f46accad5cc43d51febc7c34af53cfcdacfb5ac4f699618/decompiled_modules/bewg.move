module 0xf36241a9c0808e2a4f46accad5cc43d51febc7c34af53cfcdacfb5ac4f699618::bewg {
    struct BEWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEWG>(arg0, 6, b"BEWG", b"blue eyes white dragon on Sui", b"The first and most famous Yu-Gi-Oh card on the SUI network created by Satoshi Kaiba!  https://t.me/blueeyeswhitedragononsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_eyes_white_dragon_on_Sui_64bf520214.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

