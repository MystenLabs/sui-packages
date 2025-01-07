module 0x23e588dcc0a414d92aa96ddc403232c53a782c5c7a74bbba8f34b84a2a699ac8::mybanana {
    struct MYBANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYBANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYBANANA>(arg0, 6, b"MYBANANA", b"I'M BANANA NOW", b"THE BANANA ZONE IS HERE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731087643918.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYBANANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYBANANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

