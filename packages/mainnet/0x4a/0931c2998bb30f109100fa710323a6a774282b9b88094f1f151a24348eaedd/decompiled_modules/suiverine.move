module 0x4a0931c2998bb30f109100fa710323a6a774282b9b88094f1f151a24348eaedd::suiverine {
    struct SUIVERINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVERINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVERINE>(arg0, 6, b"Suiverine", b"$Suiverine", b"Suiverine is the first major release from fun in sui. The small but grumpy hero is one of the most powerful, respected and loved in all the multiverses... In addition to his resistance and strength, he has the ability to regenerate and his entire skeleton is made up of 100% of the most resistant metal in the entire multiverse, the Suidamantium...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suiverine_e9f27d88f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVERINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVERINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

