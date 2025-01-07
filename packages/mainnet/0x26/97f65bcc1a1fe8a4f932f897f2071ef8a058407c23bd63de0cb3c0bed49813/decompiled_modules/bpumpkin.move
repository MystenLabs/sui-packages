module 0x2697f65bcc1a1fe8a4f932f897f2071ef8a058407c23bd63de0cb3c0bed49813::bpumpkin {
    struct BPUMPKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUMPKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUMPKIN>(arg0, 6, b"BPUMPKIN", b"Baby Pumpkin", b"Tokens that will make our every day It's the most special day, every minute, every hour, every day and forever. Come join in the festivities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Halloween_Party_2_1_21fb916081.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUMPKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPUMPKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

