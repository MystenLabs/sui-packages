module 0x37d1fa28ca38a5d059870f9855ff8da36830d63bd9535d9f6f7afea34889c340::GEMS {
    struct GEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEMS>(arg0, 2, b"GEMS", b"GREAT EXPERIMENT MEME ON SUI", b"I just conducted an experiment on the SUI network involving LP burn with a 50% supply burn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/wj2M2dYm/removal-ai-c651a103-36e0-4366-b0d9-e902fef22688-gems.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEMS>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GEMS>(&mut v2, 10000000000000, @0x5481bfa16d3fd7154e4396b0dd74bc0ed2b4263d6171d68451e128ad285be54d, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

