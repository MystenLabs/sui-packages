module 0xf098e09c502f7633f32cd81e7771c86c7f96095625057c76fbce5ef494cb41::clare {
    struct CLARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLARE>(arg0, 6, b"CLARE", b"CLAYMORE", b"Clare is an iconic figure and character from Claymore", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_97e6d8b9be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLARE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLARE>>(v1);
    }

    // decompiled from Move bytecode v6
}

