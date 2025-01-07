module 0xede41e7efb4c7ca251355e13783c4b1c5f663c0afd26783027691121775d1070::suiavtr {
    struct SUIAVTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAVTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAVTR>(arg0, 6, b"SUIAVTR", b"SUIAVATAR", x"535549415641544152204f4e2054484953205748415921210a4c4153542041495242454e44455220494e2043525950544f574f524c44", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000196892_9601a36414.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAVTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAVTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

