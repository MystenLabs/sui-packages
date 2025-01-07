module 0x3aa101d964a31f3167af195ea3312060031899902ba23d619be772afbb4a81ce::tit {
    struct TIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIT>(arg0, 6, b"TIT", b"Big titties", b"You like titties ? Me too", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_13_17_16_6f8e6a5f39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

