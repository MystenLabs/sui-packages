module 0x658f80a58b790e8330942a3a9184f402f7c7cb53271908a6709d763cf63c0d41::seel {
    struct SEEL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SEEL>, arg1: 0x2::coin::Coin<SEEL>) {
        0x2::coin::burn<SEEL>(arg0, arg1);
    }

    fun init(arg0: SEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEL>(arg0, 2, b"SEEL", b"SEEL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/sonic-pokemon-unipedia/images/9/9a/86-1.png/revision/latest/scale-to-width-down/1000?cb=20131102044009")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SEEL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SEEL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

