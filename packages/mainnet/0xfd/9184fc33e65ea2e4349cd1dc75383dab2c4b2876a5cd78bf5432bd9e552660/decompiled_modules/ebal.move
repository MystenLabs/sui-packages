module 0xfd9184fc33e65ea2e4349cd1dc75383dab2c4b2876a5cd78bf5432bd9e552660::ebal {
    struct EBAL has drop {
        dummy_field: bool,
    }

    public entry fun update_description<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String) {
        0x2::coin::update_description<T0>(arg0, arg1, arg2);
    }

    public entry fun update_icon_url<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<T0>(arg0, arg1, arg2);
    }

    public entry fun update_symbol<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<T0>(arg0, arg1, arg2);
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<EBAL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<EBAL>>(arg0, arg1);
    }

    fun init(arg0: EBAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBAL>(arg0, 9, b"EBAL", b"Etti", b"Etii Meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.istockphoto.com/id/540720716/vector/blue-yeti-funny-yeti.jpg?s=612x612&w=0&k=20&c=W5l74_eHFnnHxuaQsLTqF1i76P081v1wOQC06sPHpcs=")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<EBAL>(&mut v2, 2000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBAL>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

