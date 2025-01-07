module 0xa0a0ec95a6501ef3955c3e7064f7bc052594d93c3843150beb186bcf100f9ba0::bcd {
    struct BCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCD>(arg0, 6, b"BCD", b"blockchain dog", b"blockchain dog on thah block $bcd ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mcz5_Jzhq_400x400_edf348e10b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

