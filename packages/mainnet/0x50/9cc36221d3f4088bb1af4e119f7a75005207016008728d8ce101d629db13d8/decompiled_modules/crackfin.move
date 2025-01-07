module 0x509cc36221d3f4088bb1af4e119f7a75005207016008728d8ce101d629db13d8::crackfin {
    struct CRACKFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRACKFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRACKFIN>(arg0, 6, b"Crackfin", b"SUI Crackfin", b"The Dolphin on Sui that is always high", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QY_7t_Xpma_400x400_1_6e20c4015e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRACKFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRACKFIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

