module 0x12c6072939d741567d5982d2df4a32eff9199f0de4408bfc8167cd5835e8dadb::sci {
    struct SCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCI>(arg0, 6, b"SCI", b"PoSciDonDAO", b"PoSciDonDAO is a Decentralized Autonomous Organisation (DAO) that funds personalized medicine research for life-altering diseases", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poscidondao_76955628ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

