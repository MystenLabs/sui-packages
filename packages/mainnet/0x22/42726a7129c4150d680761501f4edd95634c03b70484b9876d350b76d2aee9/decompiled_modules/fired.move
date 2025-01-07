module 0x2242726a7129c4150d680761501f4edd95634c03b70484b9876d350b76d2aee9::fired {
    struct FIRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRED>(arg0, 6, b"FIRED", b"You're Fired", b"It plays off Trump's famous line from \"The Apprentice\" with a humorous twist for holding a gun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xivn_E5_WUAA_718_I_9f17a9fbdd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

