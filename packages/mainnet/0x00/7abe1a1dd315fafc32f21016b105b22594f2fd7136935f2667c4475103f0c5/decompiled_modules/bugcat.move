module 0x7abe1a1dd315fafc32f21016b105b22594f2fd7136935f2667c4475103f0c5::bugcat {
    struct BUGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUGCAT>(arg0, 6, b"BUGCAT", b"Bugcat Capoo", b"Bugcat Capoo (Chinese: ; pinyin: Momochng Kb), sometimes abbreviated to Capoo, is a cartoon character resembling a chubby blue cat with six legs. He is the namesake and main subject of a webcomic strip on Facebook and Instagram, cartoon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sx4d_Fht_R_400x400_6f6fa9bad1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

