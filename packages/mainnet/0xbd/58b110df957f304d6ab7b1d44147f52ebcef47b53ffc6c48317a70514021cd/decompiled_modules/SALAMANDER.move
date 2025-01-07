module 0xbd58b110df957f304d6ab7b1d44147f52ebcef47b53ffc6c48317a70514021cd::SALAMANDER {
    struct SALAMANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALAMANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALAMANDER>(arg0, 9, b"SALAMANDER", b"SALAMANDER", b"Introducing the SALAMANDER, a meme cute that builds upon the resounding success of SALAMANDER on the Solana blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1749158235192377344/YVi8Gimo_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SALAMANDER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALAMANDER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SALAMANDER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SALAMANDER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

