module 0x8f902c52bd403535f216451a68bdf66cd32958d889fda961f40b213e963e3682::lordy {
    struct LORDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORDY>(arg0, 6, b"LORDY", b"Lordy sui", b"Free for all users, our custom made Lordy Gen AI bot empowers our community in creating their own special version of Lordy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LORDY_Token_CG_050a8dfbf6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

