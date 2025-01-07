module 0xa0ae232dd1bc0ec4138cd9f786ce4554a384aae579ba9b9559995bf9fc40821f::thebullrocket {
    struct THEBULLROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEBULLROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEBULLROCKET>(arg0, 6, b"TheBullRocket", b"THE BULL ROCKET", b"Once the bull saw red he skied rocket! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034468_ddbe60b2ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEBULLROCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEBULLROCKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

