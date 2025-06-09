module 0xc3b725aab7f0c89733c4c8e83eebd96ec4011b7664a68da7ee2cacf3370ddd15::base {
    struct BASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4882c0f8e7ad687dcaf0929e1268e3f28f17cc4da074ffc198cbe68b1d3daf94::bonding_curve::create_bonding_curve_v2<BASE>(arg0, b"Base", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWrLwEtkJxXtFkjJMHx9Z7xXRqoGZhTgqmq6DuBkJsxs3")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004091be95163059e183b996539b25b94c56a8df006d5e15e134b1082e301c741fc626196384637bf25d9ef7ac0b85867c662c888ce566184a85427b12a0a5470d5df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771749472345"), arg1);
        0x2::transfer::public_transfer<0x4882c0f8e7ad687dcaf0929e1268e3f28f17cc4da074ffc198cbe68b1d3daf94::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

