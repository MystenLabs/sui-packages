module 0xe53fd7f327d22eac9d23c762dbd2a29008726b6cbc837740ee210b9037192b63::titans {
    struct TITANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITANS>(arg0, 6, b"TITANS", b"THE TITANS", b"Armored in strength and united in vision, we are the defenders of innovation and pioneers of a new meme meta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0648_6c9c631510.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

