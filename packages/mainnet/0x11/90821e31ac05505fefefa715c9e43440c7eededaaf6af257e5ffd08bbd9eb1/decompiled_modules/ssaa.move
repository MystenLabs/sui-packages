module 0x1190821e31ac05505fefefa715c9e43440c7eededaaf6af257e5ffd08bbd9eb1::ssaa {
    struct SSAA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SSAA>, arg1: 0x2::coin::Coin<SSAA>) {
        0x2::coin::burn<SSAA>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut 0x2::coin::TreasuryCap<SSAA>, arg1: &mut 0x2::coin::CoinMetadata<SSAA>, arg2: 0x1::string::String) {
        0x2::coin::update_description<SSAA>(arg0, arg1, arg2);
    }

    public entry fun update_icon_url(arg0: &mut 0x2::coin::TreasuryCap<SSAA>, arg1: &mut 0x2::coin::CoinMetadata<SSAA>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<SSAA>(arg0, arg1, arg2);
    }

    public entry fun update_name(arg0: &mut 0x2::coin::TreasuryCap<SSAA>, arg1: &mut 0x2::coin::CoinMetadata<SSAA>, arg2: 0x1::string::String) {
        0x2::coin::update_name<SSAA>(arg0, arg1, arg2);
    }

    public entry fun update_symbol(arg0: &mut 0x2::coin::TreasuryCap<SSAA>, arg1: &mut 0x2::coin::CoinMetadata<SSAA>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<SSAA>(arg0, arg1, arg2);
    }

    fun init(arg0: SSAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSAA>(arg0, 9, b"aasa", b"ssaa", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSAA>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAA>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSAA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SSAA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SSAA>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer_ownership(arg0: 0x2::coin::TreasuryCap<SSAA>, arg1: 0x2::coin::CoinMetadata<SSAA>, arg2: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAA>>(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSAA>>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

