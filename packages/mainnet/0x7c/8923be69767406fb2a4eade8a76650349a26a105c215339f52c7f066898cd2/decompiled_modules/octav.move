module 0x7c8923be69767406fb2a4eade8a76650349a26a105c215339f52c7f066898cd2::octav {
    struct OCTAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTAV>(arg0, 6, b"Octav", b"Octav Sui", b"Octav sui is an octopus populating the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_02_57_11_3af60ff102.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

