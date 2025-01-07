module 0xd71bca1c869901772c5a7411424fc0a95d0b1fead9a5d1dcd16bf9b8c5f03a3::jet {
    struct JET has drop {
        dummy_field: bool,
    }

    fun init(arg0: JET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JET>(arg0, 6, b"JET", b"SUI Jet", b"keep flying high", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8ae9564b_b9b3_4b41_bdd7_00471ecd3ebf_ca23f505aa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JET>>(v1);
    }

    // decompiled from Move bytecode v6
}

