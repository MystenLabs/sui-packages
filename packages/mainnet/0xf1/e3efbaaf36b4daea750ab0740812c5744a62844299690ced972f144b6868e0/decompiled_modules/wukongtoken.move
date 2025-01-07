module 0xf1e3efbaaf36b4daea750ab0740812c5744a62844299690ced972f144b6868e0::wukongtoken {
    struct WUKONGTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONGTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONGTOKEN>(arg0, 6, b"Wukongtoken", b"Based Wukong", b"A shining star is rising on base, which perfectly combines ancient wisdom with modern technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_W6wd_THY_400x400_30555895a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONGTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUKONGTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

