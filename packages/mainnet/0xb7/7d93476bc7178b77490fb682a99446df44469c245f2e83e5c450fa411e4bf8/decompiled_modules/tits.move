module 0xb77d93476bc7178b77490fb682a99446df44469c245f2e83e5c450fa411e4bf8::tits {
    struct TITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITS>(arg0, 6, b"TITS", b"Turtle In Trenches Surviving", b"$Turtle ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_ZXB_5d3_M58ug_Zu4_GWDPD_3r_Tsj7_Np_Rd_D6o12v_ZYCX_Df6q_324b811b87.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

