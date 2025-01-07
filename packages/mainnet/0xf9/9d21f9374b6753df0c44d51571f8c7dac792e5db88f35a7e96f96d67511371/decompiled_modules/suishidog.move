module 0xf99d21f9374b6753df0c44d51571f8c7dac792e5db88f35a7e96f96d67511371::suishidog {
    struct SUISHIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIDOG>(arg0, 6, b"SUISHIDOG", b"Sui-shiDog", b"The yummiest, juiciest, cutest Suishidog is here! Gonna make your mouth and wallets waterijg for more of this.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_20_28_30_481a0147b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

