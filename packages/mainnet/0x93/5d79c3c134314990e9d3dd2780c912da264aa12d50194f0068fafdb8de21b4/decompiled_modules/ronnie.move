module 0x935d79c3c134314990e9d3dd2780c912da264aa12d50194f0068fafdb8de21b4::ronnie {
    struct RONNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONNIE>(arg0, 6, b"RONNIE", b"Ronnie on Sui", x"526f6e6e696520262052656767696562726f74686572732c2067616e6773746572206b696e67732e204c6567656e647320696e2074686520636861696e2c206c6f76656420627920616c6c2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z_CAM_Cg_SBSPN_0_Wf35_f180d8aed8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

