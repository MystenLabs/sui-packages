module 0x43fe6c341329c5d08bb331107dee67d58e5e3221ca9fdebfe6e76bf8002b7d09::dwarfy {
    struct DWARFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWARFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWARFY>(arg0, 6, b"DWARFY", b"Dwarfy", x"4477617266792c206f6e65206f66204d61747420467572696527732062656c6f76656420636861726163746572732066726f6d2022546865204e6967687420526964657273220a0a68747470733a2f2f353077617474732e636f6d2f5468652d4e696768742d526964657273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9199_b4cbebc737.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWARFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWARFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

