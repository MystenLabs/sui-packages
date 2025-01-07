module 0x867e4c378f3c765960dffb08efc97af872bd00d69aa6e5191d9c930b9a2b0027::srex {
    struct SREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SREX>(arg0, 6, b"SREX", b"suiREX", b"only hop aggregator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3z_BW_58ly_400x400_7071b93d67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

