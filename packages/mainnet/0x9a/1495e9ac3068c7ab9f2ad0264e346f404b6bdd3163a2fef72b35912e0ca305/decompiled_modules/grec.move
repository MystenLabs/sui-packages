module 0x9a1495e9ac3068c7ab9f2ad0264e346f404b6bdd3163a2fef72b35912e0ca305::grec {
    struct GREC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREC>(arg0, 6, b"GREC", b"Green Eyed Cat", b"A Green Eyed - Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_081342_89ec3508ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREC>>(v1);
    }

    // decompiled from Move bytecode v6
}

