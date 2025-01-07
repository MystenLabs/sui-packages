module 0x97c406483d9cbeecf85cc0782672e97ffeef9ddd18621c52c1dbd5ef225f6d44::dolph {
    struct DOLPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPH>(arg0, 6, b"DOLPH", b"dolphin", b"You found Flipper!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dolphin_2593e6109e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

