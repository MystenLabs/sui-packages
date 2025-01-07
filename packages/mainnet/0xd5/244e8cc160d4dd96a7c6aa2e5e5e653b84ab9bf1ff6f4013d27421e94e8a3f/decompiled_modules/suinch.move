module 0xd5244e8cc160d4dd96a7c6aa2e5e5e653b84ab9bf1ff6f4013d27421e94e8a3f::suinch {
    struct SUINCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINCH>(arg0, 6, b"Suinch", b"SuiGrinch", b"We are the Only SUINCH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/256x256_d4b0a05fc5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

