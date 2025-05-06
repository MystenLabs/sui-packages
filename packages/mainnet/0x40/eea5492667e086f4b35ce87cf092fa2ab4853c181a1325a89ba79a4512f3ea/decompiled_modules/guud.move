module 0x40eea5492667e086f4b35ce87cf092fa2ab4853c181a1325a89ba79a4512f3ea::guud {
    struct GUUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUUD>(arg0, 6, b"GUUD", b"Guud the goat", b"Guud is goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000088445_f046cdbecc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

