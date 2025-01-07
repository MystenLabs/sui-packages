module 0x7088071d170cce194ee9a03ea1ff6695e42102a185c42f343b52eab54dee7881::monkas {
    struct MONKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKAS>(arg0, 6, b"MONKAS", b"Monkas", b"Most popular emote on Twitch :MONKAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h5kki_ZI_400x400_d8b445598e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

