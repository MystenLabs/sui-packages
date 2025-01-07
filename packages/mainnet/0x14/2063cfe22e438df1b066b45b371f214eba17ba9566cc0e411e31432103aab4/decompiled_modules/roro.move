module 0x142063cfe22e438df1b066b45b371f214eba17ba9566cc0e411e31432103aab4::roro {
    struct RORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RORO>(arg0, 6, b"RORO", b"Captain Kuroro", b"Become a captain by Sailing the sui network with $RORO killing all who lost their way with us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OL_6_Etnb8_400x400_461c150fdc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

