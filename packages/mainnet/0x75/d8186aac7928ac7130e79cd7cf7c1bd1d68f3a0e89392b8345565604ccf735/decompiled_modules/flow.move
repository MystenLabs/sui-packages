module 0x75d8186aac7928ac7130e79cd7cf7c1bd1d68f3a0e89392b8345565604ccf735::flow {
    struct FLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOW>(arg0, 6, b"FLOW", b"FISHLLOWEEN", b"On a fishlloween Halloween night, deep beneath the surface of the sea, a curious little fish discovered a glowing pumpkin floating in the water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fishlow_635350299d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

