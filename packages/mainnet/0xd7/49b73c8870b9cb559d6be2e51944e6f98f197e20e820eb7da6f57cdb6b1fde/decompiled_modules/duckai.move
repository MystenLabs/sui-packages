module 0xd749b73c8870b9cb559d6be2e51944e6f98f197e20e820eb7da6f57cdb6b1fde::duckai {
    struct DUCKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKAI>(arg0, 6, b"DuckAI", b"Ducky", b"Come splash in my pond. The first sentient duck by FatduckAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l0xr_El5_400x400_1b9b9dc061.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

