module 0x8b0ddc6699701d9eee6f49e80f478b2e82483c2a18024d404658d62ec3e8baf7::liberty {
    struct LIBERTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBERTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIBERTY>(arg0, 6, b"LIBERTY", b"World Liberty Financial", b"$LIBERTY stands for freedom and power in the Sui Network, inspired by the bold vision of Donald Trump. A token of opportunity, its here to make waves and leave a mark!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ofx3yc_Ur_R_Ny_Tz4o_Hr_Q_kc_Q_583a8356af.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBERTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIBERTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

