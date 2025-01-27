module 0xca07a883696ae51b38cc92a6ebc30350184ded9e4d59f011872ccc8c5b491097::mv {
    struct MV has drop {
        dummy_field: bool,
    }

    fun init(arg0: MV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MV>(arg0, 9, b"MV", b"METAVAULT", b"This is official token of Metavault Pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akrd.net/hfO4iCMq0a2TRQ9wtJNwENNj7ShJ3EeYXbwY9N-G5HM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MV>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MV>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

