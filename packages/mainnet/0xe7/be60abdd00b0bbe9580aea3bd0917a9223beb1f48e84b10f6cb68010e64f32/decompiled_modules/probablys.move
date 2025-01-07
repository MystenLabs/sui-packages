module 0xe7be60abdd00b0bbe9580aea3bd0917a9223beb1f48e84b10f6cb68010e64f32::probablys {
    struct PROBABLYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROBABLYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROBABLYS>(arg0, 6, b"PROBABLYS", b"PROBABLYSUI", b"PROBABLY SUI OR NOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731498826522.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROBABLYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROBABLYS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

