module 0x979fafbf7729b79fb552450c9b6cae5bf84713739e7710d849ec12885545892b::ponko {
    struct PONKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKO>(arg0, 9, b"Ponko", b"Ponko", b"The ponke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PONKO>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

