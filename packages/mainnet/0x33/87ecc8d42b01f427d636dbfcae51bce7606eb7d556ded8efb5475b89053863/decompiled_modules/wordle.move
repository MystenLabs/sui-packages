module 0x3387ecc8d42b01f427d636dbfcae51bce7606eb7d556ded8efb5475b89053863::wordle {
    struct WORDLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORDLE>(arg0, 6, b"WORDLE", b"Wordle 1215", x"4f70656e20596f7572204d696e64205769746820576f72646c650a0a202020576f72646c652031323135206973207472656e64696e672045766572797768657265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_43166b8f3e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORDLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORDLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

