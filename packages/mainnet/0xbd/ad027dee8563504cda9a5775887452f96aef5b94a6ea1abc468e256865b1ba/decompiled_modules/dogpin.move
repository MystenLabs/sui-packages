module 0xbdad027dee8563504cda9a5775887452f96aef5b94a6ea1abc468e256865b1ba::dogpin {
    struct DOGPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGPIN>(arg0, 6, b"DOGPIN", b"Dogpin", x"4c657427732064657363726962652069742c20646f20796f75207468696e6b2074686973206973206120646f67206f72206120646f6c7068696e3f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052276_246629cc5f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

