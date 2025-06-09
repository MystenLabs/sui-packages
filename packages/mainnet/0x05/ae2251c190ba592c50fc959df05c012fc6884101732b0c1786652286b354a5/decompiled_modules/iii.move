module 0x5ae2251c190ba592c50fc959df05c012fc6884101732b0c1786652286b354a5::iii {
    struct III has drop {
        dummy_field: bool,
    }

    fun init(arg0: III, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4882c0f8e7ad687dcaf0929e1268e3f28f17cc4da074ffc198cbe68b1d3daf94::bonding_curve::create_bonding_curve_v2<III>(arg0, b"III", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWrLwEtkJxXtFkjJMHx9Z7xXRqoGZhTgqmq6DuBkJsxs3")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00bf5abd5fd81ebf415ddab163350ea29c229c5eb779fae100efec9cb4b0ef14c3737c342428460cb485458f55220dd0c944e97e0e947395270184f9d74ae5b2015df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771749474891"), arg1);
        0x2::transfer::public_transfer<0x4882c0f8e7ad687dcaf0929e1268e3f28f17cc4da074ffc198cbe68b1d3daf94::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<III>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

