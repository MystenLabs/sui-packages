module 0xbd6e9f487b2a51f98f16b05dfb223a003d2dc08ccb6318c999ecf0bdea5eaabf::boop {
    struct BOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOP>(arg0, 6, b"BOOP", b"Boop", b"Boop, the cutest otter just landed on Sui and is ready to send straight to the moon. Combining land and sea, this coin is definitely going to take over the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/M_LOGO_2_7ac645de7c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

