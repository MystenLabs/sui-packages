module 0xed378c6672be3d7d83ffc4ab2fc14bc7a1a266d454ee4daafa16588522374e2c::DAISY {
    struct DAISY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAISY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAISY>(arg0, 9, b"DAISY", b"DAISY - John Wick's Dog", b"DAISY - John Wick's Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746808384651931648/lnucpa51_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAISY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAISY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DAISY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DAISY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

