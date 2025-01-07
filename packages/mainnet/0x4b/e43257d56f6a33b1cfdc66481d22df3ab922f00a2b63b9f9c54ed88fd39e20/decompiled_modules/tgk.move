module 0x4be43257d56f6a33b1cfdc66481d22df3ab922f00a2b63b9f9c54ed88fd39e20::tgk {
    struct TGK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGK>(arg0, 6, b"TGK", b"TRUMoKu", b"Make Trump Great Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/966a58a2649d4834baf9db3f107ef54c_97e4a97b9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TGK>>(v1);
    }

    // decompiled from Move bytecode v6
}

