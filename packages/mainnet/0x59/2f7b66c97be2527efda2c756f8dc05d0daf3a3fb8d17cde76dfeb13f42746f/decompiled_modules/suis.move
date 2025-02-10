module 0x592f7b66c97be2527efda2c756f8dc05d0daf3a3fb8d17cde76dfeb13f42746f::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS>(arg0, 6, b"SUIS", b"suisui", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/119209_043a12b113.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

