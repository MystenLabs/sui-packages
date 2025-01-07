module 0x54cfc827a9eb00fbe9ed16808e92a062362ec2675eef094841c668a35ba7577f::memojis {
    struct MEMOJIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMOJIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMOJIS>(arg0, 6, b"MEMOJIS", b"Memojis", b"Memojis connects emojis, language, and vibes, ensuring clear, context-driven communication for a seamless digital experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/234_a3a37df489.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMOJIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMOJIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

