module 0x5834831e84773cd65d32033748dccd3ed7261398e7206263f2270d3f45b5e7d5::fight {
    struct FIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGHT>(arg0, 6, b"FIGHT", b"Fight Club", x"576861742068617070656e7320696e20666967687420636c756220737461797320696e20666967687420636c75622e20576520617265206372656174696e67207574696c69747920666f72206d656d65636f696e73207468726f7567682063617375616c2067616d6573206f6e207468652053756920626c6f636b636861696e2e2044657461696c7320696e20746865206c696e6b730a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmmmm_d34d94681d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

