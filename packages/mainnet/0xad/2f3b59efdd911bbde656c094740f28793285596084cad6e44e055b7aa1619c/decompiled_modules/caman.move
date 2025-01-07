module 0xad2f3b59efdd911bbde656c094740f28793285596084cad6e44e055b7aa1619c::caman {
    struct CAMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAMAN>(arg0, 6, b"CAMAN", b"California man Sui", b"California man accused of assaulting, tying up homeowner during burglary", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icj_Olj6j_0c0bc973b8.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

