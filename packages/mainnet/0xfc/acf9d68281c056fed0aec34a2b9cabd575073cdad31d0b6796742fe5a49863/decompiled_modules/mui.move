module 0xfcacf9d68281c056fed0aec34a2b9cabd575073cdad31d0b6796742fe5a49863::mui {
    struct MUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUI>(arg0, 6, b"MUI", b"Mui", b"Mui on Sui! Happy forever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_02_25_48_1a61a66173.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

