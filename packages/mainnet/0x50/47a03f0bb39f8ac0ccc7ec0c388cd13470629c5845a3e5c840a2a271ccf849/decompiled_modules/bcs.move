module 0x5047a03f0bb39f8ac0ccc7ec0c388cd13470629c5845a3e5c840a2a271ccf849::bcs {
    struct BCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCS>(arg0, 6, b"BCS", b"BigCockSui", b"Bigcock welcomes you all! Wishing you all a very happy and joyful day!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_b8ba0fa177.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

