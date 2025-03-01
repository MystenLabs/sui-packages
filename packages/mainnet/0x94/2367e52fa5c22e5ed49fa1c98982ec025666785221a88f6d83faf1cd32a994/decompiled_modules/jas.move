module 0x942367e52fa5c22e5ed49fa1c98982ec025666785221a88f6d83faf1cd32a994::jas {
    struct JAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAS>(arg0, 9, b"jas", b"Jas", b"Jas coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JAS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

