module 0x1d50f037b7e3119de538d7a51adea5e5fc26bb67873121279bf236d9061ec7da::snm {
    struct SNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNM>(arg0, 6, b"SNM", b"Sui-nami", b" Brace yourself for an epic surge of liquidity, community-driven fun, and tidal waves of gains. Will you ride the Sui-nami or be swept away?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_23_at_7_44_29a_PM_2042285e2b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

