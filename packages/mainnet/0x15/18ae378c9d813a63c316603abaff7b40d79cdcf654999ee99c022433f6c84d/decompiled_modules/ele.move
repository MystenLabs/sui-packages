module 0x1518ae378c9d813a63c316603abaff7b40d79cdcf654999ee99c022433f6c84d::ele {
    struct ELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELE>(arg0, 6, b"ELE", b"Elephant", b"Hey, it's the Blue Elephant talking! With my unique and vibrant hue, I stand out in the elephant world. Born from the imagination of storytellers, I'm here to bring a splash of color to our adventures. From tropical jungles to magical landscapes, my journey is a kaleidoscope of excitement and wonder. So, come along and discover the extraordinary tales of the Blue Elephant  where every adventure is painted with a touch of blue brilliance!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001993_cc8541c6e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELE>>(v1);
    }

    // decompiled from Move bytecode v6
}

