module 0x9e89c4d7b47862ee7e4dd02caa252db157b4eed24b461909ad445fa26c25f2a0::suidi {
    struct SUIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDI>(arg0, 6, b"SUIDI", b"Suidi", b"Forget \"to the moon\"thats too ordinary. $SUIDI sets its sights on something bigger: the sun. With a rapidly growing community, unstoppable hype, and a diamond-handed leader, this coin is predicted to dominate the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049623_0247d33db1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

