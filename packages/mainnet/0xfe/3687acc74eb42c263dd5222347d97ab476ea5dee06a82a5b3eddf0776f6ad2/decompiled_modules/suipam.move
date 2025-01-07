module 0xfe3687acc74eb42c263dd5222347d97ab476ea5dee06a82a5b3eddf0776f6ad2::suipam {
    struct SUIPAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPAM>(arg0, 6, b"SUIPAM", b"Sui Pam", b"Pam the bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul61_20250103011117_2aaefaa447.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

