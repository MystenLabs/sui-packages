module 0xc4e60592822260f601db9915c27075fdad2a6460fff0ec6e78eca613056ab8cc::mafia {
    struct MAFIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAFIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAFIA>(arg0, 9, b"MAFIA", b"Sui Mafia", b"Invest with Honor: Mafia Coin on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4a35e40f61c7f0d0edbc1a1b6903f349blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAFIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAFIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

