module 0xce994b33cc41fe550d29bdbe24771d863e03d0e14cb0e24b368c985bc2dd933::dogs {
    struct DOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGS>(arg0, 6, b"DOGS", b"SUI DOGS", b"First Dogs on Sui : https://www.suidogscoin.xyz | https://t.me/SuiDogs_Channel | https://t.me/SuiDogs_Channel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hero_illustration_b2df72605b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

