module 0x359285a69777649d774fdbfb5e098254c425088ed3e33be34908af37e5339ac3::kat {
    struct KAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAT>(arg0, 6, b"KAT", b"Karate Kat", b"Bullie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kat_2_cropped_14a5d3e0fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

