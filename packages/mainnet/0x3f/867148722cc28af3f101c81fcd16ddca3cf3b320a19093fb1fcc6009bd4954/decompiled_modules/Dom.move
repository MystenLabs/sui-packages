module 0x3f867148722cc28af3f101c81fcd16ddca3cf3b320a19093fb1fcc6009bd4954::Dom {
    struct DOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOM>(arg0, 9, b"LUCRE", b"Dom", b"here is he", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1874878711410872320/0IuJtdQa_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

