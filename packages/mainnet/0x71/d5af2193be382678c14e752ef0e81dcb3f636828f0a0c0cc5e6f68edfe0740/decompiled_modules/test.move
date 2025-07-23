module 0x71d5af2193be382678c14e752ef0e81dcb3f636828f0a0c0cc5e6f68edfe0740::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: 0x2::coin::Coin<TEST>) {
        0x2::coin::burn<TEST>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: &mut 0x2::coin::CoinMetadata<TEST>, arg2: 0x1::string::String) {
        0x2::coin::update_description<TEST>(arg0, arg1, arg2);
    }

    public entry fun update_icon_url(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: &mut 0x2::coin::CoinMetadata<TEST>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<TEST>(arg0, arg1, arg2);
    }

    public entry fun update_name(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: &mut 0x2::coin::CoinMetadata<TEST>, arg2: 0x1::string::String) {
        0x2::coin::update_name<TEST>(arg0, arg1, arg2);
    }

    public entry fun update_symbol(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: &mut 0x2::coin::CoinMetadata<TEST>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<TEST>(arg0, arg1, arg2);
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"test", b"test", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/Myhbug1.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer_ownership(arg0: 0x2::coin::TreasuryCap<TEST>, arg1: 0x2::coin::CoinMetadata<TEST>, arg2: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

