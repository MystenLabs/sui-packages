module 0x20f24635aedf62f35079e433b3978db15c17feb632bcfbbfdb696f373d48ede4::squack {
    struct SQUACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUACK>(arg0, 6, b"SQUACK", b"QUACK SUI", b"QUACKSUI on movepump is your unapologetic leap into a different digital world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v_Q2w2_E3q_400x400_bfd83ac612.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

