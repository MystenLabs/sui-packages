module 0x18eb5c028e9c889e5b6cefd901c0f6c1a7f08c4ca029441e0c8a480e8bf29fff::zonk {
    struct ZONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZONK>(arg0, 6, b"Zonk", b"SuiZonk", b"Get zonked and moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_071629849_f69bcb504a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

