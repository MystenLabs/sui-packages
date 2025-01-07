module 0x8d177f57b2ad1ccc8cadef1eb323d42fb415afce1ba8c87da0049a4029fca764::suisuisui {
    struct SUISUISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUISUI>(arg0, 9, b"SUISUISUI", b"SUI SUI SUI", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISUISUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUISUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

