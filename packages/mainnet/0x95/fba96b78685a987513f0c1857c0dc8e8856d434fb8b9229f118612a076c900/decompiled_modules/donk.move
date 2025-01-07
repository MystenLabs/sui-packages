module 0x95fba96b78685a987513f0c1857c0dc8e8856d434fb8b9229f118612a076c900::donk {
    struct DONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONK>(arg0, 6, b"DONK", b"donkey", b"I am the representative of all the donkeys. I speak very simply and frankly. I really want to become rich myself and make all the holders of the DONKEY token rich. Let's build a donkey community together. We can become very big and strong like dogs and Shiba and others.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_cartoon_donkey_holding_a_coin_with_the_word_donkey_written_on_it_png_1_1_9e74f1fac1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

