module 0x454941e24aa8518213c16dec6ecd0554b5679d95e695a20918d73051b57be9e1::undawg {
    struct UNDAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNDAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNDAWG>(arg0, 6, b"UNDAWG", b"Undawg the Underdog", x"4d6565742024554e444157472c204576657279626f6479206c6f76657320616e20756e646177672073746f72792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/undawg_c941d0b6a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNDAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNDAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

