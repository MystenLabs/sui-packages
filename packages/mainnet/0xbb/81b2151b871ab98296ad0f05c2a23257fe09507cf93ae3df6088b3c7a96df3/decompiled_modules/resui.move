module 0xbb81b2151b871ab98296ad0f05c2a23257fe09507cf93ae3df6088b3c7a96df3::resui {
    struct RESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESUI>(arg0, 6, b"RESUI", b"Red Sui", b"The Negative of SUI is RED SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images2_3b47c5263e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

