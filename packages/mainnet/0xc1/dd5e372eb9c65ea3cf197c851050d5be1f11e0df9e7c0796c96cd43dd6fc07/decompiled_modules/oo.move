module 0xc1dd5e372eb9c65ea3cf197c851050d5be1f11e0df9e7c0796c96cd43dd6fc07::oo {
    struct OO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OO>(arg0, 6, b"OO", b"OiiaOiia", b"OiiaOiia is a dynamic memecoin, featuring a quirky cat caught in an endless spin of excitement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_Fjjdeg_V_400x400_6000966df3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OO>>(v1);
    }

    // decompiled from Move bytecode v6
}

