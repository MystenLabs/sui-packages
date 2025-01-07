module 0xbb78535ce40ae30f20bb7a047461aa8e30f41504110e8584156617696085fda5::wsiht {
    struct WSIHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSIHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSIHT>(arg0, 6, b"WSIHT", b"WojakSlimeImaginateHawkToryinu", b"Friends who got sick of rugs and jeets and are now bonding through the power of friendship.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/realshit_6f4b95c826.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSIHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSIHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

