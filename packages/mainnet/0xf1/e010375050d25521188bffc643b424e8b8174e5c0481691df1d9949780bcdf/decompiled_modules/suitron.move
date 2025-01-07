module 0xf1e010375050d25521188bffc643b424e8b8174e5c0481691df1d9949780bcdf::suitron {
    struct SUITRON has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SUITRON", b"SUITRON", b"SUITRON TRON KILAR IS THE SUI LOVE SYMBOL OF SUUUUUUUUWEEEEEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gray-distinctive-walrus-769.mypinata.cloud/ipfs/QmQFkLRz9BZ6ACTAHeyVxa2edtJQD1S4Ti3j8Hi8K9Q1YY")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    public entry fun confirm(arg0: &mut 0x2::coin::TreasuryCap<SUITRON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITRON>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUITRON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUITRON>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

