module 0x12117541a33ac18c7c0470f08e3f51932ec3b05011babe030ecc7f0e6e866f7a::dook {
    struct DOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOK>(arg0, 6, b"DOOK", b"Shoobadookie On Sui", b"First Shoobadookie On Sui:https://shoobadookiesui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_3_d55e489341.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

