module 0xa2fd3dffdec59a738bb88672e6f6237bed8b028ff432c195ad3c1246b22c6f88::nuby {
    struct NUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUBY>(arg0, 6, b"NUBY", b"Anubis", b"Anubis is the god of death in ancient Egyptian mythology whose name means \"rot\". The name Anubis is a translation of his Egyptian name.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ivt_U_ep_A_400x400_6f1cf41263.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

