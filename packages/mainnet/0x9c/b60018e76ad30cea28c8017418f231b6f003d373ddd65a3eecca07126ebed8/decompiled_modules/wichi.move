module 0x9cb60018e76ad30cea28c8017418f231b6f003d373ddd65a3eecca07126ebed8::wichi {
    struct WICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WICHI>(arg0, 6, b"WICHI", b"WichiDog Sui", b"$WICHI is not an ordinary dog, cute but strong, intelligent and persistent, he explores the sui ocean by running fast. Unlike other dogs who attack without thinking, $WICHI carefully navigates challenges, always looking for opportunities to improve.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001429_bdc2067da6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

