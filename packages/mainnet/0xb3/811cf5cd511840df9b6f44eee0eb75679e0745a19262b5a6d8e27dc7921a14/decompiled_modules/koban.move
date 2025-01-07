module 0xb3811cf5cd511840df9b6f44eee0eb75679e0745a19262b5a6d8e27dc7921a14::koban {
    struct KOBAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KOBAN>, arg1: 0x2::coin::Coin<KOBAN>) {
        0x2::coin::burn<KOBAN>(arg0, arg1);
    }

    fun init(arg0: KOBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBAN>(arg0, 2, b"KOBAN", b"Koban", b"Lucky Kat Studios - Koban Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://QmW4s7hB7hBGp264rEqwVUeDUkZEpDyRjk2byMe9kcqji4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOBAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KOBAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KOBAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

