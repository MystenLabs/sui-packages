module 0x8f2650ab4e0eccff5a3af4206484a36a8a74d163605743b83e01b2445cc93e7e::cybercab {
    struct CYBERCAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERCAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERCAB>(arg0, 6, b"Cybercab", b"CybercabCTO", b"Cybercab cto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004522_e9e9f15ffd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERCAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBERCAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

