module 0x19c2f01f63277ee293f77435470a1af7db0825b2ac1dce29925b8c488b031298::mono {
    struct MONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONO>(arg0, 6, b"MONO", b"Monopoly", b"$MONO token rockets towards viral memecoin status, outpacing Doge, Shiba Inu, Pepe, Bonk, and others with staggering profits!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037897_a8243ceec9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

