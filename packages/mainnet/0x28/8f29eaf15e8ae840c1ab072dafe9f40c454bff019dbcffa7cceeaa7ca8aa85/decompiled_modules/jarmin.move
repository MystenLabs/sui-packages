module 0x288f29eaf15e8ae840c1ab072dafe9f40c454bff019dbcffa7cceeaa7ca8aa85::jarmin {
    struct JARMIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JARMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JARMIN>(arg0, 6, b"JARMIN", b"JARMIN SUI", x"546865206d616a657374696320244a41524d494e6973206d616b696e6720776176657320696e20746865205375692065636f73797374656d210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3ip_Tr2_L_Fs_Seg6_NPK_7_SRFW_9_Ru_Vz6c3_SZ_5itt513d_Qpump_9dd8de80b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JARMIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JARMIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

