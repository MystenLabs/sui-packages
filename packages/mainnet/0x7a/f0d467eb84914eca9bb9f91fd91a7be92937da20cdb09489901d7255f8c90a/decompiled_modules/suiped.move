module 0x7af0d467eb84914eca9bb9f91fd91a7be92937da20cdb09489901d7255f8c90a::suiped {
    struct SUIPED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPED>(arg0, 6, b"SUIPED", b"SuiPed", b"Sui Aped ($SUIPED) is a community project with a goal to bring financial freedom to every holder. SUIPED plans to grow into the biggest meme token in the crypto space with the power of a united community. Telegram : https://t.me/suipe Website : http://suiped.xyz Twitter : https://x.com/suipedcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_19_33_38_2358363a42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPED>>(v1);
    }

    // decompiled from Move bytecode v6
}

