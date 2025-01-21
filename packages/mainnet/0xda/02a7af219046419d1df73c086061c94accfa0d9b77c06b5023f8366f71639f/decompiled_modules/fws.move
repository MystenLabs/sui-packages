module 0xda02a7af219046419d1df73c086061c94accfa0d9b77c06b5023f8366f71639f::fws {
    struct FWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWS>(arg0, 6, b"FWS", b"Frog Warrior on sui", b"Welcome to the world of super frogs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ab_Bty_Q_Ga_S_Iq_M_Tsr_T_Pc_D70w_0113cb23db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

