module 0x91f7462bfc7bb5666b74dc560a3df58c377455d9a14ff5253bdb3e47b9c31e95::aaas {
    struct AAAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAS>(arg0, 6, b"aaaS", b"aaaSHARK", b"King of the SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shark_cat_aaa_1_22db6d24a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

