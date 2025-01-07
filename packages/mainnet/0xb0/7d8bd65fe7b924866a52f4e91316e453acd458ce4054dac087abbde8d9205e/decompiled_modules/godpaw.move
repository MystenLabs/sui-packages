module 0xb07d8bd65fe7b924866a52f4e91316e453acd458ce4054dac087abbde8d9205e::godpaw {
    struct GODPAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODPAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODPAW>(arg0, 6, b"GODPAW", b"GOD PAW FINGER", b"Divine intervention has a new mascot. And its fluffy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/godpaw_9441526bd2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODPAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODPAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

