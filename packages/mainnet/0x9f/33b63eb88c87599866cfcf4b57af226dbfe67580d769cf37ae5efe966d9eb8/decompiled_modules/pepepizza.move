module 0x9f33b63eb88c87599866cfcf4b57af226dbfe67580d769cf37ae5efe966d9eb8::pepepizza {
    struct PEPEPIZZA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPEPIZZA>, arg1: 0x2::coin::Coin<PEPEPIZZA>) {
        0x2::coin::burn<PEPEPIZZA>(arg0, arg1);
    }

    fun init(arg0: PEPEPIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEPIZZA>(arg0, 9, b"PEPEPIZZA", b"PEPE PIZZA", b"Pepe Pizza Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/file/d/1PdiGwXpJaUhufsC0OfdMJXygaIw0bz6m/view?usp=sharing")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEPIZZA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEPIZZA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPEPIZZA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPEPIZZA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

