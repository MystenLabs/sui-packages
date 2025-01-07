module 0x6e84e207d6a6b15b730ea7a0ac2f682b7dbce4195c60b84f8d27309f1428d828::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SUICAT", b"SUI PIXEL CAT", b"SUI PIXEL CAT SOL KILAR IS THE SUI LOVE SYMBOL OF SUUUUUUUUWEEEEEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gray-distinctive-walrus-769.mypinata.cloud/ipfs/QmcEeAnhmHrtT7DDvTWcuphQSgk2tKXZZz4k3JBR8vsxRC")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    public entry fun confirm(arg0: &mut 0x2::coin::TreasuryCap<SUICAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUICAT>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

