module 0xdb1fd8980cf931c16e7ad71c64fbf24c64e8f3f13fc700d8d18b89394a94e992::sneki {
    struct SNEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEKI>(arg0, 6, b"SNEKI", b"Sneki Sui", b"SNEKI- Little SNEK brothers who lived and grew up in the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021882_41ec68f357.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

