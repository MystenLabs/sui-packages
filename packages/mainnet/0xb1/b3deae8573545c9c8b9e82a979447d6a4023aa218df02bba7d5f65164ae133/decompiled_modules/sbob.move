module 0xb1b3deae8573545c9c8b9e82a979447d6a4023aa218df02bba7d5f65164ae133::sbob {
    struct SBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOB>(arg0, 6, b"SBOB", b"SPONGEBOB", x"2d204172652074686579206c61756768696e672061742075733f210a2d204e6f2c205061747269636b2c207468657920617265206c61756768696e67207269676874206e65787420746f2075732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spongebob_21d58190e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

