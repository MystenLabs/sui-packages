module 0xb058739a85730211adcb82419291ac44f6420e5fcb3b091e08e65247bbae1603::kirbywif {
    struct KIRBYWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRBYWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRBYWIF>(arg0, 6, b"KIRBYWIF", b"Kirby Wif Hat", b"Kirby The Baby Elephant Wif Hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kirbywif1_a1cdfaf449.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRBYWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIRBYWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

