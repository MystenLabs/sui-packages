module 0xaf9ec6988d26a5a044daf4457ffe616e0e057a6c148f009f369a2bec5b1ca3d9::OVOLS {
    struct OVOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OVOLS>(arg0, 9, b"OVOLS", b"SUI OVOLS", b"OVOLS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1726746048540901376/KrOntpAf_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OVOLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVOLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OVOLS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OVOLS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

