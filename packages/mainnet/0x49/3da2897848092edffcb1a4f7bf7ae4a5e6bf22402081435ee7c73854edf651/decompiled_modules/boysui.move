module 0x493da2897848092edffcb1a4f7bf7ae4a5e6bf22402081435ee7c73854edf651::boysui {
    struct BOYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYSUI>(arg0, 6, b"Boysui", b"Boy sui", x"46726f6d206120626f7920746f2061204b696e67202e2e2e2e2e20426f792073756920746f204b494e47204f4620535549200a434f4d4520434f4e54524f4c205448452057415445522057495448204d4520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014465_35e40cfca9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

