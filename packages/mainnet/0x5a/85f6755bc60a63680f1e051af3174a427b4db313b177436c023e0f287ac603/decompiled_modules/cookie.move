module 0x5a85f6755bc60a63680f1e051af3174a427b4db313b177436c023e0f287ac603::cookie {
    struct COOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOKIE>(arg0, 6, b"Cookie", b"COOKIESUI", b"Cookie Monster is a popular character from the children's television show Sesame Street. He is known for his insatiable appetite, especially for cookies, and his catchphrase \"Me want cookie!\". COOKIE \"JUST OM NOM NOM!!!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic7n37mp7taytu7g7e6zaoo55uci6wfhy5z4mecmtvue37mvwjtdm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COOKIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

