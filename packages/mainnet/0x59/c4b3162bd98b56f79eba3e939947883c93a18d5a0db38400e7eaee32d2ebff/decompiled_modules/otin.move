module 0x59c4b3162bd98b56f79eba3e939947883c93a18d5a0db38400e7eaee32d2ebff::otin {
    struct OTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTIN>(arg0, 6, b"OTIN", b"GECKO ON SUI", b"Otin is a character that appear in the animated series Iwj. She is a robotic agama, built by Tola's father, Tunde Martins. She was designed to protect children from kidnapping, and was given to Tola as a birthday present.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/photo_2024_09_24_23_27_25_69b1e189c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

