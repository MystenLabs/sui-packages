module 0xc2907c694ff0bc1ce1eed66de2428a0864538878c57cd66886f813a95debcfe7::eyes {
    struct EYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYES>(arg0, 6, b"EYES", b"THE EYES", b"Sui EYES , Giving the Sui community a new version ChatGPT text-image Free AI generator .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000259103_8c7d34a15e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EYES>>(v1);
    }

    // decompiled from Move bytecode v6
}

