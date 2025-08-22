module 0x5ad118e3441b82f831369d722ddff92cb0ee52ab70906fa4e5d9ee075fd47aec::irug {
    struct IRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRUG>(arg0, 9, b"irug", b"irohrug", b"iroh is a rugger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IRUG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRUG>>(v2, @0x77ae4047919c52211aa1195497698e0eb26d71219f5f9725bd2b5d1a30115800);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

