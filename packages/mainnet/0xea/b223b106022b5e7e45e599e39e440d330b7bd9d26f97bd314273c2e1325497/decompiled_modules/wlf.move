module 0xeab223b106022b5e7e45e599e39e440d330b7bd9d26f97bd314273c2e1325497::wlf {
    struct WLF has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<WLF>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WLF>>(arg0, arg1);
    }

    fun init(arg0: WLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLF>(arg0, 9, b"WLF", b"The Wolf", b"Community of Wolves coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmREBRRmJM3g3zVcpKoDnUwG8mZkNegddb9QsVw25JVfZW?filename=ikqRUzB9XlGfyw1KcLNM--3--qq3hp_2x.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<WLF>(&mut v2, 21000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLF>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

