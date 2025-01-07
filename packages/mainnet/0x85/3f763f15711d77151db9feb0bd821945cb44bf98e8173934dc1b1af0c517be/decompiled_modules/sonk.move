module 0x853f763f15711d77151db9feb0bd821945cb44bf98e8173934dc1b1af0c517be::sonk {
    struct SONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONK>(arg0, 6, b"SONK", b"SUI HONK", b"The Honk-Bonk rivalry is one of the most epic rivalries in internet meme culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1201728832428_pic_d7e3608b45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

