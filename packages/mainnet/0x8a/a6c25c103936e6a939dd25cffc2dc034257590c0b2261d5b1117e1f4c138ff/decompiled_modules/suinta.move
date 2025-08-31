module 0x8aa6c25c103936e6a939dd25cffc2dc034257590c0b2261d5b1117e1f4c138ff::suinta {
    struct SUINTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINTA>(arg0, 6, b"SUINTA", b"Suinta Clause", b"Snowing money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008799_36e16c31c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

