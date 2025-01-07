module 0xb97f9eaa03f725399e5230257474e3edecee26f53f57809627d6af5339d9841f::gamble {
    struct GAMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMBLE>(arg0, 6, b"GAMBLE", b"GAMBLE on SUI", b"We are here just to $GAMBLE. Join the casino and hav some fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a8488b82_7967_4d82_b067_c893292110d3_9dd6780864.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAMBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

