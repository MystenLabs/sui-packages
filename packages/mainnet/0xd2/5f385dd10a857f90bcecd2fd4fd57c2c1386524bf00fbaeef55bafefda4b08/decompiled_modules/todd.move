module 0xd25f385dd10a857f90bcecd2fd4fd57c2c1386524bf00fbaeef55bafefda4b08::todd {
    struct TODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TODD>(arg0, 6, b"Todd", b"Peter Todd", b"HBO Bitcoin Creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_a_a_a_a_a_a_a_a_2024_10_09_16_56_04_6130cd4176.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

