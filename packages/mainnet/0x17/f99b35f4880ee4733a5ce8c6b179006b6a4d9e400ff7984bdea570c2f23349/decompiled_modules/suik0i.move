module 0x17f99b35f4880ee4733a5ce8c6b179006b6a4d9e400ff7984bdea570c2f23349::suik0i {
    struct SUIK0I has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIK0I, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIK0I>(arg0, 6, b"SuiK0I", b"K0I", b"In a remote village, a golden Koi fish was said to bring lifelong luck and prosperity to anyone who saw it. After a storm revealed the fish to the villagers, their lives changed for the better, with abundant harvests and happiness. The Koi became a symbol of faith and hope.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29_1aea3eedb1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIK0I>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIK0I>>(v1);
    }

    // decompiled from Move bytecode v6
}

