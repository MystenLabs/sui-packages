module 0x7626c566a6404764d0d551c79946f6e1ef22e500d22a9cfc864ee1848317b233::cartel {
    struct CARTEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTEL>(arg0, 6, b"CARTEL", b"Sui Cartel", b"Introducing sui $Cartel, Coming in full gangster force to take over the sui memecoin ranks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeictvubxsgigbbde2euqalkackrkwq4tq2smsidy62sbpt7wdxt2ie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARTEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CARTEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

