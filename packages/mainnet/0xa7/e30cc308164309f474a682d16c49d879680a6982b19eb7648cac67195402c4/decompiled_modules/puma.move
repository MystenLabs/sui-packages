module 0xa7e30cc308164309f474a682d16c49d879680a6982b19eb7648cac67195402c4::puma {
    struct PUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMA>(arg0, 6, b"PUMA", b"SuiPUMA", b"SUIPUMA IS THE MOST PREDATOR IN THE SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197804_b5a7ac4ffb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

