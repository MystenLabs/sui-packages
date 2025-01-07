module 0x88606f3bb59cb1bf6d56228af09d25cf818b254d4b634f5e1c5ff59fbd6fce77::pazet {
    struct PAZET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAZET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAZET>(arg0, 6, b"Pazet", b"Leisk", b"Hey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_11_14_30_30_669052ae49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAZET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAZET>>(v1);
    }

    // decompiled from Move bytecode v6
}

