module 0x4bcf88425445173cc718a70bd89dc888112e6ba31a451497587797ac7aae950f::abe {
    struct ABE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABE>(arg0, 6, b"ABE", b"ABE ON SUI", b"The Official Bird of the Greatest Country on Earth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_Go_Rpt_Nx_400x400_a6b620fd16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABE>>(v1);
    }

    // decompiled from Move bytecode v6
}

