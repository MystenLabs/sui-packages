module 0x334927e01418ee9741d5da541d43c7b75c292e41a5c206df9e1ae75343a8fa4f::dogsai {
    struct DOGSAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGSAI>, arg1: 0x2::coin::Coin<DOGSAI>) {
        0x2::coin::burn<DOGSAI>(arg0, arg1);
    }

    fun init(arg0: DOGSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSAI>(arg0, 2, b"DOGSAI", b"DOGSAI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.im.ge/2023/05/05/ueKEjy.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGSAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGSAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

