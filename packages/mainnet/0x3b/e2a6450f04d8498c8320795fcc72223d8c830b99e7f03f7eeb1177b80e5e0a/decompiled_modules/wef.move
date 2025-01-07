module 0x3be2a6450f04d8498c8320795fcc72223d8c830b99e7f03f7eeb1177b80e5e0a::wef {
    struct WEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEF>(arg0, 6, b"WEF", b"Cheng Wif Hat", b"Sui CEO Evan Cheng WIF hat. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_29_23_18_52_2b5db85215.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

