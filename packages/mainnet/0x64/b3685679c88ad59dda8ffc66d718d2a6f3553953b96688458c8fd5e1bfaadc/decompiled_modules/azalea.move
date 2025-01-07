module 0x64b3685679c88ad59dda8ffc66d718d2a6f3553953b96688458c8fd5e1bfaadc::azalea {
    struct AZALEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZALEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZALEA>(arg0, 6, b"Azalea", b"Neiro's Sister", b"https://x.com/liza51147643740", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Xff1_FED_9_400x400_9bc1aeab3f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZALEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZALEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

