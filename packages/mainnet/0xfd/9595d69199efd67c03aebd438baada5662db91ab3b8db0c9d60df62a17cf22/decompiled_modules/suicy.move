module 0xfd9595d69199efd67c03aebd438baada5662db91ab3b8db0c9d60df62a17cf22::suicy {
    struct SUICY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICY>(arg0, 6, b"SUICY", b"Suicy sui", b"Suicy the seal was an iconic childrens toy created in 2009, Icys passions include hunting solamis, having fun and causing havoc to the typical dog, cat and frog coin. There are 30 different species of seals but Icy is the coldest one of them all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048531_72a8a24a9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICY>>(v1);
    }

    // decompiled from Move bytecode v6
}

