module 0xda1648308099414e47aff313747f33c09d7904d733f0acb1c4c79fad91b11ae2::miss {
    struct MISS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISS>(arg0, 6, b"MISS", b"Miss Suiniverse 2024", b"Miss Suiniverse 2024 Victoria Theilig from Denmark ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/missd_a4351bc7ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISS>>(v1);
    }

    // decompiled from Move bytecode v6
}

