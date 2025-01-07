module 0x6b8f0c4c95c001c8683bb7b06c8a7fed6248d51c13be45edec8d3ead42f3c136::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"Trump", b"Trump barber", b"Would you let Trump do your hair? Of course you would.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd5_DJ_Yoq_Rwoeonfk_Bo_YW_1mdba_Rqc7re6_H_Grex_P_Jjbq8_QP_86aa426266.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

