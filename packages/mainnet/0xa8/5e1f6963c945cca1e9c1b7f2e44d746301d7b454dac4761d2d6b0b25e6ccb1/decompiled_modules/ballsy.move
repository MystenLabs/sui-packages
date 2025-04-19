module 0xa85e1f6963c945cca1e9c1b7f2e44d746301d7b454dac4761d2d6b0b25e6ccb1::ballsy {
    struct BALLSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLSY>(arg0, 6, b"BALLSY", b"Ballsy on SUI", b"Grab life by the balls with Ballsy Ballsy is your unapologetic degen spirit animal Grab your Ballsy Hold tight and join the ride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_19_00_16_11_5aeeba6291.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

