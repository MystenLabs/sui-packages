module 0xcf871c0e571cd8aea30f53423a9986f4b0cdbb0c0ca125a05c43f428c4b1373f::boze {
    struct BOZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOZE>(arg0, 6, b"BOZE", b"SUIBOZE", b"Born from an autistic, $BOZE is ready to embark on a series of conquests.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bozo_f967573cb5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

