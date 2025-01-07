module 0xe9e8d05c21a04e6051c54f72b62e9e02094cdac321d6b71138371d84aabe1815::deal {
    struct DEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAL>(arg0, 9, b"DEAL", b"Seal the Deal", b"lorem ipsum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/a171783f8ccec68d20852374969ab24eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

