module 0x2875a6ef7a549c101422554c515a9e0f0ce7c1974029a448428417668e8b857f::luo {
    struct LUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUO>(arg0, 9, b"Luo", b"luof", b"gsdfsdfgrewddfsdfsdfdsc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b04a62becc0a274f72f8c23944c5cee8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

