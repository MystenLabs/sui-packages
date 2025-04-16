module 0xbb450ee73760e9c909f9c2a825155eff148249a4164e50f232643dd13f083a4c::suifur {
    struct SUIFUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUR>(arg0, 6, b"SUIFUR", b"SUI FUR", b"What if @SuiNetwork was a fur logo?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2617_fb945d4cb2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

