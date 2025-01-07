module 0xd0866d446ac15ecf0d737a9c144d57cde1e9e5b2d4e2056a36c0094c91dc184a::pesui {
    struct PESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESUI>(arg0, 6, b"PESUI", b"PEPE SUI", b"PEPE SUI - Leading Meme on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ava_c0a4793473.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

