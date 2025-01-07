module 0x70569a880eb536aab1684a61ac1cb7a50afb6eb1e327bbcab9ed2df92d201985::cookie {
    struct COOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOKIE>(arg0, 6, b"Cookie", b"Cookie Monsui", b"Me love cookies! Love sharing cookies with all me friends on @sesamestreet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cookie_a194c71dfa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

