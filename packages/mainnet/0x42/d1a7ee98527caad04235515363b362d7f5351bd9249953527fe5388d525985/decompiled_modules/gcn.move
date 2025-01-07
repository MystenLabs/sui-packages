module 0x42d1a7ee98527caad04235515363b362d7f5351bd9249953527fe5388d525985::gcn {
    struct GCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCN>(arg0, 9, b"GCN", b"Google Chain Network", b"Google Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GCN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

