module 0xb6e3979471a2384a12d9420e343e6e6483d3b07662b3ebe36585726671c8924f::scati {
    struct SCATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCATI>(arg0, 6, b"SCATI", b"SUI CATI", b"landing on the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_06_225655_efef1f8686.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

