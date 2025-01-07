module 0xf95425e3f46532ebe5bea62120088669e7d3f172ccc486f3eb72e6f551e7bf15::wfarm {
    struct WFARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFARM>(arg0, 6, b"wFARM", b"Water Farm", x"5468652062696767657374206c6971756964697479204661726d696e672070726f6a656374206f6e20746865205761746572436861696e21200a0a416464206c697175696469747920746f206661726d20526577617264732066726f6d204d6f766550756d70210a0a3e31302c30303025415059206f6e2024774641524d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001253_4659e5887f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WFARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

