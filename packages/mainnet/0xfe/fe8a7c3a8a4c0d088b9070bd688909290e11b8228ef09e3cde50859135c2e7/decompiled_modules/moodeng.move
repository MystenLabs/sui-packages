module 0xfefe8a7c3a8a4c0d088b9070bd688909290e11b8228ef09e3cde50859135c2e7::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"MOODENG", b"Moodeng on Sui", x"42656c69657665206974206f72206e6f742c20746865736520686970706f7320617265205245414c21205468657920617265206e6f772074616b696e67206f7665722074686520696e7465726e657420617320746865206c6174657374206d656d652073656e736174696f6e2e2047657420726561647920666f7220637574656e657373206f7665726c6f61640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/532112312131231_74a2a17d56_05b182e9f6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

