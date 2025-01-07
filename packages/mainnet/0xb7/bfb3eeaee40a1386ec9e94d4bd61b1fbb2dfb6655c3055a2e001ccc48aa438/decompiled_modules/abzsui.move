module 0xb7bfb3eeaee40a1386ec9e94d4bd61b1fbb2dfb6655c3055a2e001ccc48aa438::abzsui {
    struct ABZSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABZSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABZSUI>(arg0, 6, b"ABZSUI", b"God of Fresh Water", x"41627a7520726570726573656e74656420756e64657267726f756e642066726573682077617465722e0a486520776173207468652066617468657220616e64207072656465636573736f72206f66206561726c7920676f64732e0a41627a75206d69786564207761746572732077697468204e616d6d6120746f2063726561746520676f64732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixlr_image_generator_a8bd678b_c0a6_4f1c_bc47_540f0a94b907_02cb02249e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABZSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABZSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

