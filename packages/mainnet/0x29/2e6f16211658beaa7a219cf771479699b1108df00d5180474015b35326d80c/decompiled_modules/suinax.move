module 0x292e6f16211658beaa7a219cf771479699b1108df00d5180474015b35326d80c::suinax {
    struct SUINAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAX>(arg0, 6, b"SUINAX", b"SuinaX", b"The certified Bad-Ass Diva on Sui, bringing Glamour, Hotness, and an Empire on the rise to claim her crown as the ultimate Queen of the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profile_5203b5bfa8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

