module 0x89da1c8baeb9944c928dc5766648a2da46c035b9e90c007b7df3b874120bb77b::popo {
    struct POPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPO>(arg0, 6, b"POPO", b"Popo The Community Cat", b"The first memecoin of @SeiNetwork V2, Run by the $SEI community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u5gpq_Nm_400x400_eeb5da9229.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

