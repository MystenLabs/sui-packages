module 0xe4d92455a47cb8ee99531ff413129cb5ea09a19bbae8f329c1b019c1d3d32075::tai {
    struct TAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAI>(arg0, 6, b"TAI", b"Trump AI Agent", b"TRUMP AI - Empowering America with $TAI. Full autonomous Trump AI Agent in control. Here to make AI Great Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0450_f1b7388050.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

