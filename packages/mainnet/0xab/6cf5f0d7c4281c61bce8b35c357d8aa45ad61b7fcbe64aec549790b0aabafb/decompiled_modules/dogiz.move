module 0xab6cf5f0d7c4281c61bce8b35c357d8aa45ad61b7fcbe64aec549790b0aabafb::dogiz {
    struct DOGIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGIZ>(arg0, 6, b"Dogiz", b"Dogezilla", b"Dogezilla now on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_l1200_9bc77a57dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

