module 0x29a03427c4068c58c08f444ee587b4a2d00cf0fb1de8b9a11753454ae5dad4b2::wocc {
    struct WOCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOCC>(arg0, 6, b"WOCC", b"Winner Of Cats Club", b" Winner Of Cats Club is powered by a leading crypto team focused on driving mass adoption of cryptocurrency!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726394501035_0671cb8496fda285836f348b250f7653_d37ef62b59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

