module 0x8794213401ed6396beae5b561ef8362580509d6cb5a70db117541ceb4c1e48d1::miffy {
    struct MIFFY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MIFFY>, arg1: 0x2::coin::Coin<MIFFY>) {
        0x2::coin::burn<MIFFY>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut 0x2::coin::TreasuryCap<MIFFY>, arg1: &mut 0x2::coin::CoinMetadata<MIFFY>, arg2: 0x1::string::String) {
        0x2::coin::update_description<MIFFY>(arg0, arg1, arg2);
    }

    public entry fun update_icon_url(arg0: &mut 0x2::coin::TreasuryCap<MIFFY>, arg1: &mut 0x2::coin::CoinMetadata<MIFFY>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<MIFFY>(arg0, arg1, arg2);
    }

    public entry fun update_name(arg0: &mut 0x2::coin::TreasuryCap<MIFFY>, arg1: &mut 0x2::coin::CoinMetadata<MIFFY>, arg2: 0x1::string::String) {
        0x2::coin::update_name<MIFFY>(arg0, arg1, arg2);
    }

    public entry fun update_symbol(arg0: &mut 0x2::coin::TreasuryCap<MIFFY>, arg1: &mut 0x2::coin::CoinMetadata<MIFFY>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<MIFFY>(arg0, arg1, arg2);
    }

    fun init(arg0: MIFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIFFY>(arg0, 9, b"miffy", b"miffy", b"https:/t.me/miffysui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/8oiSoCr.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIFFY>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIFFY>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIFFY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIFFY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MIFFY>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer_ownership(arg0: 0x2::coin::TreasuryCap<MIFFY>, arg1: 0x2::coin::CoinMetadata<MIFFY>, arg2: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIFFY>>(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIFFY>>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

