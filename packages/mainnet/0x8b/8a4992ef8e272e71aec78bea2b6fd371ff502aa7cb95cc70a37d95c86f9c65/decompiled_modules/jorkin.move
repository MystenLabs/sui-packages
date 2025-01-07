module 0x8b8a4992ef8e272e71aec78bea2b6fd371ff502aa7cb95cc70a37d95c86f9c65::jorkin {
    struct JORKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JORKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JORKIN>(arg0, 6, b"JORKIN", b"JORKIN OFF ON SUI", b"Let's jork together cuz Jorkins together, Jorkins stronger!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wc9_Uqg_ET_8_W1_PEG_Ud_Vy_S_Car_N_Ktg_Sk_Usn_N2xh_Efk33_Q_Dsa_5610cc379d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JORKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JORKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

