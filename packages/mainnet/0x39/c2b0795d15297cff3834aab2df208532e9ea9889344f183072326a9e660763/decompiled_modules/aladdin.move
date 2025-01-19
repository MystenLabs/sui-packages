module 0x39c2b0795d15297cff3834aab2df208532e9ea9889344f183072326a9e660763::aladdin {
    struct ALADDIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALADDIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALADDIN>(arg0, 6, b"ALADDIN", b"Aladdin", b"The best Aladdin coin on the Sui chain. No rugs, just carpets. Flying ones. Enjoy  the flight!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aladdinpic_5e4b1c5f09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALADDIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALADDIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

