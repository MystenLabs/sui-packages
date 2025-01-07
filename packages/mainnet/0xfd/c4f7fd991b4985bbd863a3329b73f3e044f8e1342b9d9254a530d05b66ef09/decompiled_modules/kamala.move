module 0xfdc4f7fd991b4985bbd863a3329b73f3e044f8e1342b9d9254a530d05b66ef09::kamala {
    struct KAMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALA>(arg0, 6, b"KAMALA", b"KAMALA HARIS", x"4b414d414c41204f4e205355490a4a4f494e2068747470733a2f2f742e6d652f6b616d616c61737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051416_bb96086d07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

