module 0x31afdf40b4c32f2db9b014cdf39ca67da44362fca995d595dcdc14b2ffcb7142::suihoal {
    struct SUIHOAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHOAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHOAL>(arg0, 6, b"SuiHoAl", b"SuiHomeAlabama", x"537765657420686f6d6520416c6162616d61210a576572652074686520736b6965732061726520736f20626c756521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5568_13009edaa0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHOAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHOAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

