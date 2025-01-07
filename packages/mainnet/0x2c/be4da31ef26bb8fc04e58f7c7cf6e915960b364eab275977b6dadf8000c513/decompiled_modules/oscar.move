module 0x2cbe4da31ef26bb8fc04e58f7c7cf6e915960b364eab275977b6dadf8000c513::oscar {
    struct OSCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSCAR>(arg0, 6, b"OSCAR", b"Oscar the octo", b"With his eight tentacles, Oscar could multitask like no other, managing smart contracts, optimizing gas fees, and even creating his own memecoin. His unique ability to change colors made him the perfect symbol for the ever-changing world of cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037757_280596157d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

