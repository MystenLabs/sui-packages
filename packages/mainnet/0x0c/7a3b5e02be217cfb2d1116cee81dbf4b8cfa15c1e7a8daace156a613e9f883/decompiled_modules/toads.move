module 0xc7a3b5e02be217cfb2d1116cee81dbf4b8cfa15c1e7a8daace156a613e9f883::toads {
    struct TOADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOADS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOADS>(arg0, 6, b"TOADS", b"TOAD SPACE", b"An innovative initiative that combines science, technology and creativity to explore space from the perspective of a small but brave amphibian. \"The Space Frog\" is a project that seeks to send a robotic model of a frog equipped with advanced sensors to study extreme conditions outside of Earth, such as microgravity, radiation and unknown atmospheres. This project symbolizes the curiosity and adaptability of living beings, inspiring future generations in space exploration.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_31_20_50_51_5ae5eefa92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOADS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOADS>>(v1);
    }

    // decompiled from Move bytecode v6
}

