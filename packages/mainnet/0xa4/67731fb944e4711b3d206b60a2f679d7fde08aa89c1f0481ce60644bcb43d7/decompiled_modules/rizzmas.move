module 0xa467731fb944e4711b3d206b60a2f679d7fde08aa89c1f0481ce60644bcb43d7::rizzmas {
    struct RIZZMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZMAS>(arg0, 6, b"RIZZMAS", b"RIZZMAS on SUI", b"This is our first project so you arent entirely wrong, but look at what has come of this. We now have the community it takes to get  this coin to 100Mil market cap by December 25st.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dqpdw_F5q_400x400_0a305cd122.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

