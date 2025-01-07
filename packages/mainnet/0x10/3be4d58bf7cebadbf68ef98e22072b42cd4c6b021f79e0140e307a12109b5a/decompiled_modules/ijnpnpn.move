module 0x103be4d58bf7cebadbf68ef98e22072b42cd4c6b021f79e0140e307a12109b5a::ijnpnpn {
    struct IJNPNPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IJNPNPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IJNPNPN>(arg0, 6, b"ijnpnpn", b"ijnpnpn", b"in", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IJNPNPN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IJNPNPN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IJNPNPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

