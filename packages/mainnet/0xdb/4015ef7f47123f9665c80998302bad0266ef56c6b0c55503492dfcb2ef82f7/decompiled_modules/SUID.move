module 0xdb4015ef7f47123f9665c80998302bad0266ef56c6b0c55503492dfcb2ef82f7::SUID {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 9, b"SUID", b"SuiDEX", b"The first AMM (Automated Market Maker) on the SUI blockchain, created to enable safe and decentralized token swaps. The protocol uses smart contracts developed by our team, written in the MOVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suidex.io/metadata/SUID.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUID>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUID>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SUID>>(0x2::coin::mint<SUID>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

