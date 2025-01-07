module 0x792e2e2329f1413168c78a58aa071b0148fbf1b0a946390781b8600ff1e38724::socks {
    struct SOCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCKS>(arg0, 6, b"SOCKS", b"Socks", b"In this March 19, 1994 file photo, Socks the cat peers over the podium in the White House briefing room in Washington. Socks, the White House cat during the Clinton administration, has died. He was about 18.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0013729e42d20b0c864b23_91294d45be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

