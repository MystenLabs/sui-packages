module 0xaea2e705cecdfa798680215a92c2766f8ad49bfee4a2d3420b10460a8fc30527::SUISLIME {
    struct SUISLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISLIME>(arg0, 6, b"SLIME", b"SUI SLIME", b"Basically, as a slime, Sui would eat anything. Sui Slime is a special individual whose normal size is a bowling ball, and the color is light blue.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/L6grFX5/400jpg.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISLIME>>(v1);
        0x2::coin::mint_and_transfer<SUISLIME>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISLIME>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun renounceOwnership(arg0: 0x2::coin::TreasuryCap<SUISLIME>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISLIME>>(arg0, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v6
}

