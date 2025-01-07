module 0xf5c09d528cf909e18dd177f0a5c8f5bf419f83de79c839afc8a76ba4342781ef::suitama {
    struct SUITAMA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITAMA>, arg1: 0x2::coin::Coin<SUITAMA>) {
        0x2::coin::burn<SUITAMA>(arg0, arg1);
    }

    fun init(arg0: SUITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAMA>(arg0, 9, b"suitama", b"$TAMA", b"https://t.me/SuitamaSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/keuQfTJ.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITAMA>>(v1);
        0x2::coin::mint_and_transfer<SUITAMA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAMA>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITAMA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITAMA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

