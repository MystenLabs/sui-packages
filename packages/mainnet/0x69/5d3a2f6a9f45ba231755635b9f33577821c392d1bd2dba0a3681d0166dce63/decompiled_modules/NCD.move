module 0x695d3a2f6a9f45ba231755635b9f33577821c392d1bd2dba0a3681d0166dce63::NCD {
    struct NCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCD>(arg0, 6, b"NCD", b"nonchalant dreadhead", b"everybody wants to be him", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmW69fuYtuQTv2qpDXpSDtKMYjJfsFVjSykdFsn2jA3Dat")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NCD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

