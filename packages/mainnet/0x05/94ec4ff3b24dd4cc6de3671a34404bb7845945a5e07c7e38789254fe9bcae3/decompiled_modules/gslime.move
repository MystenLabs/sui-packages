module 0x594ec4ff3b24dd4cc6de3671a34404bb7845945a5e07c7e38789254fe9bcae3::gslime {
    struct GSLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSLIME>(arg0, 9, b"GSLIME", b"Galactic Slimecoin", b"In the year 3021, a group of eccentric space explorers discovered a glowing, gooey substance on a distant planet. They named it 'Slime' and soon realized it could power their ships and devices. The Slime became so popular that it spawned a new currency, Galactic Slimecoin, which instantly became the most sought-after resource in the galaxy. As the currency spread, so did the tales of its mystical properties, leading to a craze among interstellar traders and adventurers alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739201486/vfiairihjnp6ze6hfkwe.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSLIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSLIME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

