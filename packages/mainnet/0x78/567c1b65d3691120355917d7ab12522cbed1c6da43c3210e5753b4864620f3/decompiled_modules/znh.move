module 0x78567c1b65d3691120355917d7ab12522cbed1c6da43c3210e5753b4864620f3::znh {
    struct ZNH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZNH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZNH>(arg0, 6, b"ZNH", b"Zenithion", b"Zenithion is a forward-thinking token designed to lead the way in innovation and growth. Positioned at the pinnacle of the blockchain ecosystem, Zenithion aims to empower investors with strong potential and strategic advancements. With a focus on stability and ambition, Zenithion represents the journey toward reaching the highest point of success. Join the ascent with Zenithion and achieve new heights!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/677_B47_AB_C602_4_F1_F_A834_E2_BAF_272_EBF_8_41011cc141.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZNH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZNH>>(v1);
    }

    // decompiled from Move bytecode v6
}

