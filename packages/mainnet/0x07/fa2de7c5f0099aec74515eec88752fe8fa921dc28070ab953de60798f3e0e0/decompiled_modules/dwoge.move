module 0x7fa2de7c5f0099aec74515eec88752fe8fa921dc28070ab953de60798f3e0e0::dwoge {
    struct DWOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWOGE>(arg0, 6, b"DWOGE", b"DwogeCoin", x"486520697320737563682048617070790a4865206973206d75636820706c617966756c0a4865206973207665727920636865656b790a496620616e6e6f7965642c206265636f6d6573206576696c0a4c6f76657320636f6d69632073616e7320666f6e740a486973206d6f74746f3a202244776f206f6e6c792067776f6f64206576657779646179220a48652069732044776f67652020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040095_e01711fccc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

