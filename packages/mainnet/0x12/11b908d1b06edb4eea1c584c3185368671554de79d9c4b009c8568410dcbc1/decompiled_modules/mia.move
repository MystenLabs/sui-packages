module 0x1211b908d1b06edb4eea1c584c3185368671554de79d9c4b009c8568410dcbc1::mia {
    struct MIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIA>(arg0, 9, b"MIA", b"Mia Khalifa", b"mia for best live miami", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

