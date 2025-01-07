module 0xba17036a92448862a7746efdd0a1d0d21bf549bbbc9b7aad6937fc92df11b46e::nomnom {
    struct NOMNOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOMNOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOMNOM>(arg0, 6, b"NOMNOM", b"nomnom", b"I eat all things. Trash, Ass, Cash, i have an apetite for all of that.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EK_Eu_Cwni_400x400_ac2ed6a79a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOMNOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOMNOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

