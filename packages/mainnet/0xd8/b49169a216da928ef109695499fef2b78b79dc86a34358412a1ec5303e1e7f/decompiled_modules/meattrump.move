module 0xd8b49169a216da928ef109695499fef2b78b79dc86a34358412a1ec5303e1e7f::meattrump {
    struct MEATTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEATTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEATTRUMP>(arg0, 6, b"Meattrump", b"Meat Trump", b"Nice to meat the president.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7cff48abbb3e3ff918f6e820a9607589_255322844_cfb2e1b112.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEATTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEATTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

