module 0xe93d0b258b39da1e35a4d568197a2b3af4ae30b6e5e34bf8c2d59e557df5f94a::thirsty {
    struct THIRSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: THIRSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THIRSTY>(arg0, 6, b"THIRSTY", b"Thirsty Sponge Bob", b"Thirsty Sponge Bob ($THIRSTY) Bikini Bottoms most dehydrated sponge is here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_55_88a08a5ef4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THIRSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THIRSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

