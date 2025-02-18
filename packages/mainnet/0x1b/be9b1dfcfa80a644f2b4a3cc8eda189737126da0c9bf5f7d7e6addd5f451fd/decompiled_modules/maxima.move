module 0x1bbe9b1dfcfa80a644f2b4a3cc8eda189737126da0c9bf5f7d7e6addd5f451fd::maxima {
    struct MAXIMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXIMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXIMA>(arg0, 9, b"MAXIMA", b"Maxima", b"The best token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://clearboxtoys.com/wp-content/uploads/2023/11/harry-potter-and-the-Prisoner-of-Azkaban-250x250.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAXIMA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXIMA>>(v2, @0xc2f45aa0ee89058023c1bbfd64a710d43ec5f6b16e52590bbad92d6a09a235e6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAXIMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

