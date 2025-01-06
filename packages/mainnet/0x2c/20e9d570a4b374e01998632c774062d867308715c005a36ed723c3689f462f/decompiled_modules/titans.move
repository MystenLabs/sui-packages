module 0x2c20e9d570a4b374e01998632c774062d867308715c005a36ed723c3689f462f::titans {
    struct TITANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITANS>(arg0, 6, b"TITANS", b"Titans of SUI", b"Armored in strength, united in vision. Defenders of innovation and builders of a new meme meta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tit_d68541bb97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

