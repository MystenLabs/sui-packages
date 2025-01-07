module 0x43ef07751d0fbaa41e30f0daf6d4e68313d7ed45744ca5d23593f05a7da12ddc::lfg {
    struct LFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFG>(arg0, 6, b"LFG", b"LET THE FUCKING GO!!!", b"lfg!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/153ac59288c1d0eb571e083b2b73fb9_cb6c197df1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

