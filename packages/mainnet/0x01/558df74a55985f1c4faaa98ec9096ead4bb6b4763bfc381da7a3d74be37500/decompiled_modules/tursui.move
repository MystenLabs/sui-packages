module 0x1558df74a55985f1c4faaa98ec9096ead4bb6b4763bfc381da7a3d74be37500::tursui {
    struct TURSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURSUI>(arg0, 6, b"TURSUI", b"Turtle On Sui", b"The Boys Club meta is outstanding. We have Pepe pumping along with, WOLF, and BRETT. $TURSUI While we know all of these coins are heading towards Pepes market cap, we thought we would create the new version", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_12_e036a4d8ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

