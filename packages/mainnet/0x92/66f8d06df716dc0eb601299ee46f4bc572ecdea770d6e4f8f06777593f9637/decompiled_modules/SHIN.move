module 0x9266f8d06df716dc0eb601299ee46f4bc572ecdea770d6e4f8f06777593f9637::SHIN {
    struct SHIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHIN>, arg1: 0x2::coin::Coin<SHIN>) {
        0x2::coin::burn<SHIN>(arg0, arg1);
    }

    fun init(arg0: SHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIN>(arg0, 9, b"SHIN", b"Shin Chan", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/PYbLJmF/shin.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

