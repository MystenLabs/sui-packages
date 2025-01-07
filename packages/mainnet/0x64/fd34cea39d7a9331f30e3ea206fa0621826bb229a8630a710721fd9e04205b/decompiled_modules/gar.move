module 0x64fd34cea39d7a9331f30e3ea206fa0621826bb229a8630a710721fd9e04205b::gar {
    struct GAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAR>(arg0, 6, b"GAR", b"SUIGAR", b"Stealth Launh , Meme + Play and earn $Sui on-chain! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pot_Ic4l_U_400x400_8470f5337a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

