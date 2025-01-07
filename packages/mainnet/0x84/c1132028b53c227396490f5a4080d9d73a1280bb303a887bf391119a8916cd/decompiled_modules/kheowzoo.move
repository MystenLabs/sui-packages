module 0x84c1132028b53c227396490f5a4080d9d73a1280bb303a887bf391119a8916cd::kheowzoo {
    struct KHEOWZOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHEOWZOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHEOWZOO>(arg0, 6, b"Kheowzoo", b"KHEOWZOO", b"Unofficial, memecoin of #kheowzoo on #SuiNetwork. All dev tokens belongs to community. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000742685_102150b6e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHEOWZOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KHEOWZOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

