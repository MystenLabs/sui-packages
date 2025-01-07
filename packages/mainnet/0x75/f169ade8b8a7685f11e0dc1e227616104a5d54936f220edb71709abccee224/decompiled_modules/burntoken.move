module 0x75f169ade8b8a7685f11e0dc1e227616104a5d54936f220edb71709abccee224::burntoken {
    struct BURNTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURNTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURNTOKEN>(arg0, 6, b"Burntoken", b"$burn", b"get burned ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2_3a6ff1ff9a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURNTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURNTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

