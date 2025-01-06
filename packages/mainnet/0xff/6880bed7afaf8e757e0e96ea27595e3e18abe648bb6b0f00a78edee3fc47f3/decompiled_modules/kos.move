module 0xff6880bed7afaf8e757e0e96ea27595e3e18abe648bb6b0f00a78edee3fc47f3::kos {
    struct KOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOS>(arg0, 6, b"KOS", b"Katara On Sui", b"You're not the only one who draws power from the moon - katara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5963_1908056b63.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

