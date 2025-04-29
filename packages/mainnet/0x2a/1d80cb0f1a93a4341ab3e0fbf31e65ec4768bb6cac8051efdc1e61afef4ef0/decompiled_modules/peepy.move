module 0x2a1d80cb0f1a93a4341ab3e0fbf31e65ec4768bb6cac8051efdc1e61afef4ef0::peepy {
    struct PEEPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEPY>(arg0, 6, b"PEEPY", b"Peeping Duck", x"4d656574202450454550592c205468652050656570696e67204475636b2074686174277320616c77617973207761746368696e67206f76657220796f752e200a24504545505920697320696e73706972656420627920616e61746964616570686f6269617468652066656172207468617420736f6d6577686572652c20736f6d65686f772c2061206475636b206973207761746368696e6720796f752e20576974682050656570696e67204475636b2c207468617420706172616e6f6961206265636f6d657320796f757220706f7765722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peepylogo_f83af8d68d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

