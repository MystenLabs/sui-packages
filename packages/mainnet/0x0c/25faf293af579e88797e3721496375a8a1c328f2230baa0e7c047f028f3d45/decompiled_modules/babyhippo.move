module 0xc25faf293af579e88797e3721496375a8a1c328f2230baa0e7c047f028f3d45::babyhippo {
    struct BABYHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYHIPPO>(arg0, 6, b"BabyHippo", b"Baby Hippo", x"42616279486970706f206d656d65206f6e205375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4222c639_8e82_4ea5_be09_d979ef89f23f_61058fa959_4c8facb3bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

