module 0x725c3bd702fe26d79f75acbbb21f382d1497c68037e6a5375fd16c1ee700a715::suey {
    struct SUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUEY>(arg0, 6, b"SUEY", b"Suey The Seal", b"Suey the seal was an iconic childrens toy created in 2009, Sueys passions include hunting suilamis, having fun and causing havoc to the typical dog, cat and frog coin. There are 30 different species of seals but Suey is the coldest one of them all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker21_c2e2b2c713.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

