module 0xa914f19f9956dec755e91cf94ca2476967313e27345f4696a4add86ae665a5ef::robotaxi {
    struct ROBOTAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOTAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOTAXI>(arg0, 6, b"ROBOTAXI", b"robotaxi", b"https://www.investors.com/news/tesla-stock-elon-musk-robotaxi-event/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_05_06_03_ec7d7dc927.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOTAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOTAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

