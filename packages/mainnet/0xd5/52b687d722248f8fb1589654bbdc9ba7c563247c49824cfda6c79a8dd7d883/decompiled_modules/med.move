module 0xd552b687d722248f8fb1589654bbdc9ba7c563247c49824cfda6c79a8dd7d883::med {
    struct MED has drop {
        dummy_field: bool,
    }

    fun init(arg0: MED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MED>(arg0, 9, b"MED", b"Medici", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MED>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MED>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MED>>(v1);
    }

    // decompiled from Move bytecode v6
}

