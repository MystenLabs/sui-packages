module 0xceacb16166e919097650e660420e78c1b448e3535bbbaeb79112f2151d2a2692::suihara {
    struct SUIHARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHARA>(arg0, 6, b"Suihara", b"Suihara AI Agent", b"Suihara is a futuristic humanoid character with feline-inspired features and robotic enhancements, blending grace and technology seamlessly. Adorned in a sleek blue design, Suihara emanates a captivating aura of intelligence and agility, embodying both elegance and strength. Her glowing accents and mechanical details highlight her advanced AI core, making her a symbol of harmony between humanity and innovation in a futuristic world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11eb26e2_180e_4b9f_8726_aaa9fdb2752b_84e55ae900.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

