module 0xbc27973a58b7282e68c54d1db569fef3f1620d309b30f102c12302fa5c503179::mooncake {
    struct MOONCAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONCAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONCAKE>(arg0, 6, b"Mooncake", b"MoonCake", b"jia ren men! zhong qiu  jie kuai le!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s5k_Y_Ql9_R3_N_5313ed5908.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONCAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONCAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

