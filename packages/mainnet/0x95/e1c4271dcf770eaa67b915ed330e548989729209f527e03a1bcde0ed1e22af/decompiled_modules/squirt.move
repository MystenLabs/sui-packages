module 0x95e1c4271dcf770eaa67b915ed330e548989729209f527e03a1bcde0ed1e22af::squirt {
    struct SQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRT>(arg0, 9, b"SQUIRT", b"Squirt Reynolds", b"I wanna mustache dammit! I wanna look Like Squirt Reynolds!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"0x378B1CD993e3233f9352c841c7876d9D5D1E779D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SQUIRT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

