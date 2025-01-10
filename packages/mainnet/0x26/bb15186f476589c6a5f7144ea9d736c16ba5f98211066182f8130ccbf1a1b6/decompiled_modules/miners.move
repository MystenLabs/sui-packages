module 0x26bb15186f476589c6a5f7144ea9d736c16ba5f98211066182f8130ccbf1a1b6::miners {
    struct MINERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINERS>(arg0, 6, b"MINERS", b"Miner Ai on Sui", x"4d696e65725320697320616c736f2076657279206465666c6174696f6e6172792c20776974682061206d6178696d756d20737570706c79206f66206f6e6c792031302062696c6c696f6e0a0a746f6b656e732e2054686973206d65616e732074686174206173206d6f72652070656f706c652062757920616e6420686f6c64204d696e6572532c20746865207072696365206f660a74686520636f696e2077696c6c20636f6e74696e756520746f20726973652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_5_0939b0a170.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

