module 0x90a922c433576ff3e3303eaf1051839d94b1894034636dc865307c07ab91431a::clawcat {
    struct CLAWCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAWCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWCAT>(arg0, 6, b"Clawcat", b"Claw cat", b"claw cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pawnzi111_d1763d8cb6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAWCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

