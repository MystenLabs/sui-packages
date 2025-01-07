module 0x9a588cdf2ffbb9f329661331c8f257a5b29316f0129212b7f14153535720457a::bulma {
    struct BULMA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BULMA>, arg1: 0x2::coin::Coin<BULMA>) {
        0x2::coin::burn<BULMA>(arg0, arg1);
    }

    fun init(arg0: BULMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULMA>(arg0, 2, b"BULMA", b"BULMA", b"BULMA ON SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BULMA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BULMA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

