module 0xdaa8de1302c506595e2928b6063cee0c643224cbfed257b42ee7bb23ebe783a3::pluf {
    struct PLUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUF>(arg0, 6, b"Pluf", b"PlufloSui", b"https://x.com/PlufloToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_061811_c95866eba9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

