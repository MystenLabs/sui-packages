module 0xd4e4cc654f7db6e0511aeb66b9b3f7eec24ec888dc92fa39fde89ca18d92592d::lwt {
    struct LWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LWT>(arg0, 9, b"Lwt", b"Landlwhale", b"Walter Whalington was a phalantrorfish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"content://media/external/downloads/1000000587")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LWT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LWT>>(v2, @0xeb2c089aa1487d98a058f1e022a7da5b8ea24700b243eb6f87995c3cacad4d16);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LWT>>(v1);
    }

    // decompiled from Move bytecode v6
}

