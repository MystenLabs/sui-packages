module 0x3771f766e6c8dc28d56f2ac804323311dfdcd8073f0bbff67acdc1d555c40a77::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 9, b"FOMO", b"Fear of missing out!", b"Fear of missing out)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ih1.redbubble.net/image.4746859034.9047/st,small,845x845-pad,1000x1000,f8f8f8.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOMO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

