module 0xaf942e149f992ece32ce851e658800c998039fecfac7d08767ef5f804b54c1bc::lazy {
    struct LAZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAZY>(arg0, 2, b"Lazy", b"Lazy Cat", b"Lazi Cat fair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://down-id.img.susercontent.com/file/id-11134207-7r98w-lt1xgh3kbv4619")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAZY>(&mut v2, 48000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAZY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

