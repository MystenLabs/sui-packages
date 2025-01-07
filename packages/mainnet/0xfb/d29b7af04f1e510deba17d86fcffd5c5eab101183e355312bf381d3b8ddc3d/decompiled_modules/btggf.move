module 0xfbd29b7af04f1e510deba17d86fcffd5c5eab101183e355312bf381d3b8ddc3d::btggf {
    struct BTGGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTGGF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BTGGF>(arg0, 6, b"BTGGF", b"Big Tiddy Goth GF", b"I'm just a big tiddy goth GF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/btggf_051931979d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BTGGF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTGGF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

