module 0x5e59fa35d8a800dd87c3119e79e6cc1d879606a7fddce3c4553ae52ac00cd173::pat {
    struct PAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAT>(arg0, 6, b"PAT", b"PAT SUI", b"The first and only matt furry boys club character on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000165945_2912c839c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

