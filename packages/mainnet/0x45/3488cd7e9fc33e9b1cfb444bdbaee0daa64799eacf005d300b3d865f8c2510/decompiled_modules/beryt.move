module 0x453488cd7e9fc33e9b1cfb444bdbaee0daa64799eacf005d300b3d865f8c2510::beryt {
    struct BERYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERYT>(arg0, 6, b"BERYT", b"BERYT SUI", b"The first shark created by China's Aquarium is getting attention", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_02_01_10_38_04_55a5ab8527.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERYT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERYT>>(v1);
    }

    // decompiled from Move bytecode v6
}

