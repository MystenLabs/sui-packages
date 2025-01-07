module 0x16a5fdccc17a2d973079e536b3262a28d1d7323e792b8c08c462636946bbef17::suishell {
    struct SUISHELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHELL>(arg0, 6, b"SUISHELL", b"SEASHELL of SUI OCEAN", b"$SUISHELL is a token on Sui, inspired by the beauty of a seashell with a hidden pearl inside. Just like a rare treasure found in the ocean, $SUISHELL holds great value for its holders. Dive into the Sui Sea and discover the pearl within $SUISHELL!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUISHELL_88161644b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

