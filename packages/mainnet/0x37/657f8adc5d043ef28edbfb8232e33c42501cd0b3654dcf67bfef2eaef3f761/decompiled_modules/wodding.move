module 0x37657f8adc5d043ef28edbfb8232e33c42501cd0b3654dcf67bfef2eaef3f761::wodding {
    struct WODDING has drop {
        dummy_field: bool,
    }

    fun init(arg0: WODDING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WODDING>(arg0, 6, b"Wodding", b"Doraemon meme", b"is meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/005_H_Kr_Q2gy1hr9qdwii2cj30wi1yctyh_edit_46230247206269_33a597dd92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WODDING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WODDING>>(v1);
    }

    // decompiled from Move bytecode v6
}

