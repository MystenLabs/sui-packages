module 0x434aef47ae497ab2e386c1686af4a9a6bef6112981eac54e1333d43898daf09b::aaarat {
    struct AAARAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAARAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAARAT>(arg0, 6, b"AAARAT", b"AAA RAT", b"AAA RAT, HOLD TIGHT FOR MOON LANDING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_27_03_04_01_4a0ef00deb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAARAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAARAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

