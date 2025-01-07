module 0xd8dc70c430c8a4fbbe6ece8e2075981eddf448a8ca8f7151e7b13c05a04c7a51::dogefather {
    struct DOGEFATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEFATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEFATHER>(arg0, 6, b"Dogefather", b"The Dogefather", b"https://x.com/elonmusk/status/1839195677710008417", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogefather_9042d15e9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEFATHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEFATHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

