module 0x790f6ca8c796f3431c415002986f5a45b3d08d7c50af140c30e2d85d241129a2::sopcat {
    struct SOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOPCAT>(arg0, 6, b"SOPCAT", b"SOPCAT SUI", x"534f50434154206973206e6f77206f6e2020535549204e6574776f726b21200a0a496e7370697265642066726f6d2074686520706f70756c6172206d656d652d636174206e616d65642022506f70636174222c20536f70636174206a7573742064726f70706564206f6e2020535549204e6574776f726b2120204e6f206c6f6e676572206a7573742061206d656d652c4974732068657265212020546865206c6567656e6461727920536f70636174206861732061727269766564206f6e205355492c20616e6420746869732069736e74206a75737420616e7920636f696e2064726f706974732074686520756c74696d617465206d656d6520736c61702e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sopcat_da6d566686.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

