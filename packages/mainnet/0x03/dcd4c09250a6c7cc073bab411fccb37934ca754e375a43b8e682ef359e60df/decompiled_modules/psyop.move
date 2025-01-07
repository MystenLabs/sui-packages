module 0x3dcd4c09250a6c7cc073bab411fccb37934ca754e375a43b8e682ef359e60df::psyop {
    struct PSYOP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PSYOP>, arg1: 0x2::coin::Coin<PSYOP>) {
        0x2::coin::burn<PSYOP>(arg0, arg1);
    }

    fun init(arg0: PSYOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSYOP>(arg0, 9, b"PSYOP", b"PSYOP ", b"PSYOP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1595481185068597248/vPgn5glR_400x400.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSYOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSYOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PSYOP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PSYOP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

