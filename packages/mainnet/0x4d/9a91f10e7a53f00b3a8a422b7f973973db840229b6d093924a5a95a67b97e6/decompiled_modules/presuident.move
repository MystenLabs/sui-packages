module 0x4d9a91f10e7a53f00b3a8a422b7f973973db840229b6d093924a5a95a67b97e6::presuident {
    struct PRESUIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESUIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRESUIDENT>(arg0, 6, b"PRESUIDENT", b"Presuident Trump", b"Only the PRESUIDENT can save us! The road to 4.7 MarketCap starts here! The official telegram opens at 4.7M marketcap! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5236_b0aa2ecefe.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRESUIDENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRESUIDENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

