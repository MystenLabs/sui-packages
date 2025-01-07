module 0x3399887148d14493a9f369b3a27d930b9a4170f955c9bf553b7c1d4f474e7b9f::buster {
    struct BUSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUSTER>(arg0, 6, b"BUSTER", b"BUSTERSUI", x"244255535445522041204672656e63682042756c6c646f67206f6e205375692077686f20686173206120686561727420746f2068656c70206f7468657220616e696d616c732e0a0a466f6c6c6f77206f7572206c6174657374206e657773206f6e205477697474657220616e642054656c656772616d20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241209_070230_958_511818c079.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

