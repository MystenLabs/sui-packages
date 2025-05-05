module 0x65ee61f3b993f7572f7dc7813be0b07744d581bee632e5dc4b3527a07eccf71c::musky {
    struct MUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSKY>(arg0, 6, b"MUSKY", b"DONKEY MUSKY", b"Hi, my name is MUSKY the sui-donkey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2025_05_05_at_19_22_37_1bcf0803a9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

