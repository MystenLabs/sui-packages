module 0x4d5f8e73ec2d9b8a1de38a603be2657adc8eb69909e41ccce24db79be995210a::suikit {
    struct SUIKIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKIT>(arg0, 6, b"SuiKit", b"Sui Kit", b"I'm looking for Rin Tin Tin on the sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012577_54d23145e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

