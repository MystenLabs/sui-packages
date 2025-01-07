module 0xf76c6fc241cdd695ce3e115068e1eee0d886d20f39fe8f501c472694b8c1dee2::suity {
    struct SUITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITY>(arg0, 6, b"SUITY", b"SUINITY", b"Suinity is a community platform dedicated to blockchain, fostering token exchange and the discovery of innovative projects. With a simple interface, it allows users to track their investments and connect with a dynamic community. Its an ecosystem where innovation and collaboration shape the future of decentralized finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A6_A140_EB_63_A7_4947_91_F9_C2019_C2_E0_FD_5_e7519c44cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

