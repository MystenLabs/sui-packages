module 0x5ed52a6831a440347cea11b47fd07966c46d8c083b886043e04412eef6983dd1::crab {
    struct CRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAB>(arg0, 6, b"Crab", b"Blue Eyed Crab With Knife", b"A dangerous but cute blue-eyed crab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_eyed_crab_w_knife_b94c2c4bdc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

