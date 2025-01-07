module 0x7fde144949f6a2a8d9fc36789cdd537b16f204a609ea6e7818e6f252147a8455::tdf {
    struct TDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDF>(arg0, 6, b"TDF", b"The DogeFather", b"Elon Musk isnt the President or the Prime Ministerhe will be the Dogefather of the United States of America. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_23_121753_994ebcb29b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

