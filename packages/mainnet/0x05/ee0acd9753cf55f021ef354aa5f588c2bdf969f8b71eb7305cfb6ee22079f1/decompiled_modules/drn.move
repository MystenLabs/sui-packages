module 0x5ee0acd9753cf55f021ef354aa5f588c2bdf969f8b71eb7305cfb6ee22079f1::drn {
    struct DRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRN>(arg0, 6, b"DRN", b"Dragon", b"The awakening of suigon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/afa2679a946361f9d795e648bd230978_adc601cf95.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

