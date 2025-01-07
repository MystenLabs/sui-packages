module 0xab71c4fb34f42d0b8ac106b77cc3fe107c4316e89b84d17ddba6c1f640b42259::suixb {
    struct SUIXB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXB>(arg0, 0, b"SuixB", b"The SuixB", b"This is SuixB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bizweb.dktcdn.net/thumb/grande/100/463/551/products/ghim-cai-quan-ao-hinh-con-meo-them-hoa-tiet-ngon-lua.jpg?v=1697609881703")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIXB>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXB>>(v2, @0x9d01d9f7b776e75a1a63c5561b68d68c302e232ce91abbd105e6897ebaae19fa);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIXB>>(v1);
    }

    // decompiled from Move bytecode v6
}

