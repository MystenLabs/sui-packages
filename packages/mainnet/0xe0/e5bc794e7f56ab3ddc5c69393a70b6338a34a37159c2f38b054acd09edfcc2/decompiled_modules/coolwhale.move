module 0xe0e5bc794e7f56ab3ddc5c69393a70b6338a34a37159c2f38b054acd09edfcc2::coolwhale {
    struct COOLWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLWHALE>(arg0, 6, b"COOLWHALE", b"Cool Whale", b"This coin is made for the big players by the big players. Its time for everyone to swim with the big fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/wha_5f4741c812.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOLWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

