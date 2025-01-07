module 0x57448431bf586f1d70685cf4780b60ef383fec7c2a7413aee5a1649fceb0f763::finhop {
    struct FINHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINHOP>(arg0, 6, b"FinHop", b"FinHopper", b"FinHopper is here to earn!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9817adeb_9fa3_4b22_9682_694dab90b91b_a7c91159b9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

