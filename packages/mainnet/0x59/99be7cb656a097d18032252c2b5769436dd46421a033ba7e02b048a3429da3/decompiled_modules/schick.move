module 0x5999be7cb656a097d18032252c2b5769436dd46421a033ba7e02b048a3429da3::schick {
    struct SCHICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHICK>(arg0, 6, b"SCHICK", b"Sonic Chicken", x"536f6e6963436869636b656e20282453434849434b2920697320746865206e65776573742c207370656564696573742c20616e64206d6f737420656e65726765746963206d656d6520636f696e20746f20646174652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SCHICK_T_Ww_Gwf_4ex_Fwje3z_Qy_Q_b9e8f61af4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

