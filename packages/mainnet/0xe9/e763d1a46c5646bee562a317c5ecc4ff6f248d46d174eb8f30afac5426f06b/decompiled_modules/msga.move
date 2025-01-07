module 0xe9e763d1a46c5646bee562a317c5ecc4ff6f248d46d174eb8f30afac5426f06b::msga {
    struct MSGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSGA>(arg0, 6, b"MSGA", b"Make Sui Great Again", b"Make Sui Great Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_crisp_bright_blue_baseball_cap_with_a_curve_2_729d84756a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

