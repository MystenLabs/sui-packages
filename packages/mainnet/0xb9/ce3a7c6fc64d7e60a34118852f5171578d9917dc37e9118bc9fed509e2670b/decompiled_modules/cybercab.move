module 0xb9ce3a7c6fc64d7e60a34118852f5171578d9917dc37e9118bc9fed509e2670b::cybercab {
    struct CYBERCAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERCAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERCAB>(arg0, 6, b"Cybercab", b"Robotaxi Cybercab", b"TESLA Robotaxi on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0822_ca2c9aed56.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERCAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBERCAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

