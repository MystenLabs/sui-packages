module 0x1ca125ff518363bab87265eb816493c2857537d338774e873034228ce1fcbc16::spste {
    struct SPSTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPSTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPSTE>(arg0, 6, b"SPSTE", b"SUI-PASTE", x"7768617420646f20737569206465767320627275736820776974683f3f3f0a0a535549205041535445454545", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_BFB_7670_9_B45_4054_80_EA_D5_D4495_F5_D6_D_7573b1609d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPSTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPSTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

