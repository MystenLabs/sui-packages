module 0x1a9182dd779368ee93b24dfaf757f145bf2e4b45136d4d25781dfa203cd232c::cherry {
    struct CHERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHERRY>(arg0, 6, b"Cherry", b"Cherry Baby", x"436865727279206973206120746563686e6f6c6f677920636f6d70616e79206261736520696e20486f6e67204b6f6e672c20746865206d61696e20627573696e65737320697320656475636174696f6e2c204750552074726164696e672c2063726f73732d626f7264657220656c656374726f6e696320636f6d6d657263652e0a546865206f6e6520736861726520686f6c646572206f66204368657272792069732061206c697374696e6720636f6d70616e7920696e2055532e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_2065006028_3790514268_and_fm_253_and_fmt_auto_and_app_138_and_f_JPEG_17376bd13a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

