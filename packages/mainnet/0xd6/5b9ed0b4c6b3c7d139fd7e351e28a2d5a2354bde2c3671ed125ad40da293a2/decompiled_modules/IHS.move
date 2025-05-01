module 0xd65b9ed0b4c6b3c7d139fd7e351e28a2d5a2354bde2c3671ed125ad40da293a2::IHS {
    struct IHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IHS>(arg0, 6, b"IHS", b"Indomitable Human Spirit", b"When im last at the 100 man vs gorilla fight but all the souls of the 99 comrades that fell call out to me from the afterlife so i can end this fight and kill the gorilla (they believe in me.... *I* believe in me)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/Qmf29Cy9QwoqcgmFBwzTRB2Sw2bBNaVEkayxqUMavVi15t")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IHS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IHS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

