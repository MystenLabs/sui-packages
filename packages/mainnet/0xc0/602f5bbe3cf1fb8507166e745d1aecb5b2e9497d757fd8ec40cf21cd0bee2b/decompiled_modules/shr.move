module 0xc0602f5bbe3cf1fb8507166e745d1aecb5b2e9497d757fd8ec40cf21cd0bee2b::shr {
    struct SHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHR>(arg0, 6, b"SHR", b"Shroom", b"Native token of WonderGame", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Beu_Y_Kj_GW_400x400_9df58bcab7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

