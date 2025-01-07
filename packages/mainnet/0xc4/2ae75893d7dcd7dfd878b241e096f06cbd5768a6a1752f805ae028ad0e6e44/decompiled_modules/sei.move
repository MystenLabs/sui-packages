module 0xc42ae75893d7dcd7dfd878b241e096f06cbd5768a6a1752f805ae028ad0e6e44::sei {
    struct SEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEI>(arg0, 6, b"SEI", b"One of the hardest technical things in crypto right now is distinguishing SUI SEI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd6oP1hYD5fOXo9o2JDWS7nCZ67WRKHNXnFQ&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEI>(&mut v2, 2222222223000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

