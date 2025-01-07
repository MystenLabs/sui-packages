module 0x9be77d39cd00301864cedf6386bc3628758f6c72303544ebbea3a4055ed4b076::kam {
    struct KAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAM>(arg0, 6, b"KAM", b"Kamala", b"~~~~Kamala!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_ac01d118e8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

