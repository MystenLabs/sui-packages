module 0x4dc4bb5493e924e6495c559fc2102bc5c639e7504d73b65222331b0f221b8fb5::toby {
    struct TOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBY>(arg0, 6, b"TOBY", b"TOBY SUI", b"a project #memecoin by sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g04l_S_Aup_400x400_b3356c420c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

