module 0x5e37fb1cd84a8d6a704d869ab35d87434587f077b93b445a30544b43015e4f0f::gkl {
    struct GKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GKL>(arg0, 9, b"Gkl", b"fgf", b"hihji", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/785bf30a8d75abd75e036c83500497e4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GKL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GKL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

