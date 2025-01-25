module 0xe40172aa2f1fb5b469a60e1900bc30e946bff87abf2c21cc2a59134af67d7e2f::bas {
    struct BAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAS>(arg0, 6, b"BAS", b"Baby Agent S", b"The son of Agent S that wants to follow his footsteps", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/agent_341dfa7345.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

