module 0x4dae5fbcf0dc496662bb138125f3bbfe2f9563eab897f8fc72986a75976f6331::tick {
    struct TICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICK>(arg0, 6, b"TICK", b"The Tick", b"In a world where superheroes and villains have been real for decades, Arthur, an unassuming accountant with no superpowers, becomes embroiled in the middle of the battle between good and evil. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dfc1f704_f904_43b0_bc80_915e46a74516_5e15c80791.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

