module 0xe95c7e5849b0c3abd423d9851a09063d8c2e0d008f34f2d3b16c724bf1d8dd9d::buychartele {
    struct BUYCHARTELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUYCHARTELE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUYCHARTELE>(arg0, 6, b"BUYCHARTELE", b"ELEPHANT", b"Hey, it's the Blue Elephant talking! With my unique and vibrant hue, I stand out in the elephant world. Born from the imagination of storytellers, I'm here to bring a splash of color to our adventures. From tropical jungles to magical landscapes, my journey is a kaleidoscope of excitement and wonder. So, come along and discover the extraordinary tales of the Blue Elephant  where every adventure is painted with a touch of blue brilliance!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_17_29_51_407ccbcf2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUYCHARTELE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUYCHARTELE>>(v1);
    }

    // decompiled from Move bytecode v6
}

