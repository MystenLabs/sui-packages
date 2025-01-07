module 0x81dc11141ff1fd158595e3dd4f1b89b8804ec879784478ba06e20b47788de53::dev {
    struct DEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV>(arg0, 6, b"DEV", b"My dog is the dev", b"$DEV is a meme coin with no intrinsic value or expectation of financial return", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dog_1f22366e1a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

