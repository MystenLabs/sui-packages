module 0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg {
    struct SWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWG>(arg0, 9, b"SWG", b"suiwin ghost", b"I am the ghost of SuiWin Game, a memecoin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8a510b68af1579651e26818194373e65blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

