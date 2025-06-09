module 0xfdb450a859e018dd0ad6100715fd1ce444b9e9fabc19d4da386e0b02f23e2951::base {
    struct BASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4882c0f8e7ad687dcaf0929e1268e3f28f17cc4da074ffc198cbe68b1d3daf94::bonding_curve::create_bonding_curve_v2<BASE>(arg0, b"Base", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWrLwEtkJxXtFkjJMHx9Z7xXRqoGZhTgqmq6DuBkJsxs3")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0068fe2ba2613c07c54e50c25189ca20dd15e370e5cd5e2cc9ec20fe33ff809ceee2565df23b74dbe839c21a6ff7bdc07ea55f17e1926361887b92a49e785da2075df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771749472446"), arg1);
        0x2::transfer::public_transfer<0x4882c0f8e7ad687dcaf0929e1268e3f28f17cc4da074ffc198cbe68b1d3daf94::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

