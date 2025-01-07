module 0x60bf52fcd4582111c276ccb7149ea87c003c12c7b794ccf9e8bc8f8df47f23b3::suingers {
    struct SUINGERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINGERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINGERS>(arg0, 6, b"SUINGERS", b"SUINGERS PARTY", b"There's no party like a SUINGERS party", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2975b6d3_1ab8_4e35_bcea_4d6d65e8efff_bde4146afa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINGERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINGERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

