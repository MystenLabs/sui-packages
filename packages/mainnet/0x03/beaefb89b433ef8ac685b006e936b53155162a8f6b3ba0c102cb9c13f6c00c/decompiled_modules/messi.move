module 0x3beaefb89b433ef8ac685b006e936b53155162a8f6b3ba0c102cb9c13f6c00c::messi {
    struct MESSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSI>(arg0, 9, b"MESSI", b"MESSI Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSCVjkxcJJSPWoAWu1kw7hKX2kOb_Va1fLLWTtWdEoh-TmBA47WxI15xYD4aRqb6UPj5L00OzCwMqzcW_Y6ofaEzAiJRrQPGcfbXvAhvA"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MESSI>(&mut v2, 1000000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MESSI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MESSI>>(v2);
    }

    // decompiled from Move bytecode v6
}

