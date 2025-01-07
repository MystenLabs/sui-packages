module 0xb839c1d6ea7ec84253bc47ad1163d9d1afe7f33261196ed489b321bb018f45a0::spookify {
    struct SPOOKIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOKIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOKIFY>(arg0, 6, b"Spookify", b"SPOOKIFY", b"Spookify the best meme for this halloween in Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fc262880_533d_4cc7_9e66_7c0d1e3520d2_a60ed029a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOKIFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOOKIFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

