module 0x2ef6f5786d9c21085a2c53d5754b4e91f8c91548bdcb57855fc09296dbf3bdf::booga {
    struct BOOGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOGA>(arg0, 9, b"Booga", b"Booga on Sui", b"Giga Booga want pamp pamp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWq8pUi8umZArgGeENTzuy2oELzWiR7X2Gqyn4BZtdPSk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOGA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

