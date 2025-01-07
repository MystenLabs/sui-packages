module 0x111815ec17e6845d988286cf6a006a8f41ecfeac949c7a3d359562f864b0bd4a::sasa {
    struct SASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASA>(arg0, 6, b"SASA", b"SardineOnSui", b"Sardines will ride the waves of hype", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000606_3b45bc11e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASA>>(v1);
    }

    // decompiled from Move bytecode v6
}

