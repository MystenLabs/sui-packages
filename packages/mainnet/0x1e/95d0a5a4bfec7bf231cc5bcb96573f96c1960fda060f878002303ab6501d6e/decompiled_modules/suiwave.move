module 0x1e95d0a5a4bfec7bf231cc5bcb96573f96c1960fda060f878002303ab6501d6e::suiwave {
    struct SUIWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWAVE>(arg0, 6, b"SuiWave", b"Sui Wave", x"5768656e20796f75207468696e6b206c69666520697320612063616c6d207365612c20627574205375692077617665730a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vv_d190c805be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

