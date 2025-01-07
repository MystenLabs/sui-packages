module 0xd25a18f354f8f61de2e8694463efe375c9b39b208b1f0bb8d7d351a1b0ade981::lsui {
    struct LSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSUI>(arg0, 6, b"LSUI", b"LAPRAS SUI", b"$LSUI is a #Meme coin of #Sui blockchain. Let's make dream come true with #LSUI $Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9c93eff8ea8e348c06c0c55d13aeb219_3dcb83190a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

