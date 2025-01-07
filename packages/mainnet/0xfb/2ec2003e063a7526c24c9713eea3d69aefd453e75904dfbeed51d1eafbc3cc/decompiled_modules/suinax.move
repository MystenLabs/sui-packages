module 0xfb2ec2003e063a7526c24c9713eea3d69aefd453e75904dfbeed51d1eafbc3cc::suinax {
    struct SUINAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAX>(arg0, 6, b"SUINAX", b"SuinaX", b"The certified Bad-Ass Diva on Sui, bringing Glamour, Hotness, and an Empire on the rise to claim her crown as the ultimate Queen of the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profile_a7fbc98223.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

