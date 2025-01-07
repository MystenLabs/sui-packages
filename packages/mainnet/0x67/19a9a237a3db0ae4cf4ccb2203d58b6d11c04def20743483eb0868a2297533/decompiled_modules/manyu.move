module 0x6719a9a237a3db0ae4cf4ccb2203d58b6d11c04def20743483eb0868a2297533::manyu {
    struct MANYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANYU>(arg0, 6, b"Manyu", b"Little manyu", b"World known dog all over tiktok and instagram MANYU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013581_acb8abda57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

