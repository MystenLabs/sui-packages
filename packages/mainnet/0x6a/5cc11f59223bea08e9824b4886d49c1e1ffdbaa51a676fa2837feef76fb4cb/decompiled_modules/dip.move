module 0x6a5cc11f59223bea08e9824b4886d49c1e1ffdbaa51a676fa2837feef76fb4cb::dip {
    struct DIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIP>(arg0, 6, b"DIP", b"Buy The F**KING DIP", x"4e6f2054472c206e6f20547769747465722c206e6f204b4f4c732c206e6f204253e280946a757374204255592054484520462a2a4b494e4720444950210a0a446f6ee2809974206c65742074686520636162616c73207368616b6520796f75206f7574206f6620796f757220626167732e2041726520796f752031323f204e6f2e20596f75e280997265206120662a2a6b696e6720646567656e65726174652e20536f20616374206c696b65206f6e6520616e64204255592054484520462a2a4b494e472044495021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734726170630.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

