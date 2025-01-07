module 0xad32cd84e8b71e6790ff7740edbe9d74b1b64014b705c361624047d44dd8ff36::honk {
    struct HONK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HONK>, arg1: 0x2::coin::Coin<HONK>) {
        0x2::coin::burn<HONK>(arg0, arg1);
    }

    fun init(arg0: HONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONK>(arg0, 9, b"honk", b"honk", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/SoB2zED.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HONK>>(v1);
        0x2::coin::mint_and_transfer<HONK>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONK>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HONK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HONK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

