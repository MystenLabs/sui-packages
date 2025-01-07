module 0xdf365e003c151b89897e47e5ee712cbaca216ea3212af11e874e3aa0958d4963::octav {
    struct OCTAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTAV>(arg0, 9, b"OCTAV", b"Octav", b"Octav is an octopus populating the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FOctav_5cee62f612.jpg&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OCTAV>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTAV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

