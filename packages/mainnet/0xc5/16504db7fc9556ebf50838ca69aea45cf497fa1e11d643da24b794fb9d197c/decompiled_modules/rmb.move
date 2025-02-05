module 0xc516504db7fc9556ebf50838ca69aea45cf497fa1e11d643da24b794fb9d197c::rmb {
    struct RMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMB>(arg0, 8, b"RMB", b"RMB", b"this is renmingbi", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RMB>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RMB>>(v0);
    }

    // decompiled from Move bytecode v6
}

