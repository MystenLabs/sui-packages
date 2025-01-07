module 0x783034d7bcbaf976c9c38d6015a00d0cf18b3f8a29c3a8e3b63a50779e336018::kingjulien {
    struct KINGJULIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGJULIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGJULIEN>(arg0, 6, b"KINGJULIEN", b"I like to move it move it", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.thesun.co.uk/wp-content/uploads/2020/09/NINTCHDBPICT000598252454.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KINGJULIEN>(&mut v2, 6969696970000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGJULIEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGJULIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

