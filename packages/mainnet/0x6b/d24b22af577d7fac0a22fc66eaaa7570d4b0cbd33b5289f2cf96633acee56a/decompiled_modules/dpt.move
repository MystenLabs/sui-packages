module 0x6bd24b22af577d7fac0a22fc66eaaa7570d4b0cbd33b5289f2cf96633acee56a::dpt {
    struct DPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPT>(arg0, 6, b"DPT", b"DEEPtober", b"memecoin dedicated the deepbook community and upcoming tge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015273_998a2c80a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

