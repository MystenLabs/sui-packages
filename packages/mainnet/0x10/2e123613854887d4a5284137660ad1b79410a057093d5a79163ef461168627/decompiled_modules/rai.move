module 0x102e123613854887d4a5284137660ad1b79410a057093d5a79163ef461168627::rai {
    struct RAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAI>(arg0, 6, b"RAI", b"RED EYAI", b"look at my eye if u wanna be rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bf545786_900c_4294_8058_316e0b7ee0aa_51b12ddd91.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

