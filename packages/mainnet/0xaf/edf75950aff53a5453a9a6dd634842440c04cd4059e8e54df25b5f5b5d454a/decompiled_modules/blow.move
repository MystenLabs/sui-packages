module 0xafedf75950aff53a5453a9a6dd634842440c04cd4059e8e54df25b5f5b5d454a::blow {
    struct BLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOW>(arg0, 6, b"BLOW", b"Sui Blow", b"Meet $BLOW, a new coin featuring a blue cat mascot on SUI Network, aiming to reach new milestones and take over the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/New_Project_2024_10_13_T194407_605_c6c90254e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

