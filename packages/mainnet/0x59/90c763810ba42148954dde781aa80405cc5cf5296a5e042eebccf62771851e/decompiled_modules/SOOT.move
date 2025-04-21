module 0x5990c763810ba42148954dde781aa80405cc5cf5296a5e042eebccf62771851e::SOOT {
    struct SOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOOT>(arg0, 6, b"SOOT", b"i like my suitcase", b"i like... i like my SOOTCASE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmUg9yet1PUujWA56iY13qpGBHX6MG3MoDezCPVfbmmZ5V")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

