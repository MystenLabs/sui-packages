module 0xab369862eb5c9594447e8bb14ee397e92f692b6f867dbb45589cf3056dfd9689::sassy {
    struct SASSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASSY>(arg0, 6, b"Sassy", b"Sassy Seahorse", b"From Sassy to classy swimming the Sui seas ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_ECFCC_15_6831_4059_9_BF_1_5891_FA_497147_b7ce5390dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

