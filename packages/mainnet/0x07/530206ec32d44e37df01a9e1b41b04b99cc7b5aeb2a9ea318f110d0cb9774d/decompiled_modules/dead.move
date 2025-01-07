module 0x7530206ec32d44e37df01a9e1b41b04b99cc7b5aeb2a9ea318f110d0cb9774d::dead {
    struct DEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAD>(arg0, 9, b"DEAD", b"Dead Coin", b"The end is near!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/CgQoqef.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEAD>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

