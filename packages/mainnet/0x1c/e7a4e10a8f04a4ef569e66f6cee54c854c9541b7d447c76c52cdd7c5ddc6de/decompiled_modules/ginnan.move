module 0x1ce7a4e10a8f04a4ef569e66f6cee54c854c9541b7d447c76c52cdd7c5ddc6de::ginnan {
    struct GINNAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINNAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GINNAN>(arg0, 6, b"GINNAN", b"Doge's Brother", b"Ginnan the Cat, affectionately known as Doge's brother, is one of the most wholesome meowing machines on the internet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_58_741a300227.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINNAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GINNAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

