module 0xe3e7e8753ebbcb9cfca080e9c10e7b06a79e0317cad318e01e7130f576a4f612::stnk {
    struct STNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STNK>(arg0, 6, b"STNK", b"STONKS COIN", x"546865206669727374206d656d65636f696e206465706c6f796564206f6e205355492e200a4261636b65642062792074686520495020746f20746865206d656d652e200a53746f6e6b732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hzmrc_P_B_400x400_364897fae1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

