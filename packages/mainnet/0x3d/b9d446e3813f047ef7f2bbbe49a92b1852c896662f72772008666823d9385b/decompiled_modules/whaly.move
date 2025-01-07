module 0x3db9d446e3813f047ef7f2bbbe49a92b1852c896662f72772008666823d9385b::whaly {
    struct WHALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALY>(arg0, 9, b"WHALY", b"WHALY", b"WHALY crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/ads/asset/a6ee3157e24c8f1180ed531a8c87014708a88fc9.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHALY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

