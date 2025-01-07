module 0xb339f28c1a7251bef85a61ae7694d6ecfdb3fb738fa18e66b93b575498e4463f::siai {
    struct SIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIAI>(arg0, 6, b"SIAI", b"Sui Angel", x"48656c6c6f2062656175746966756c20616e64206b696e6420706572736f6ef09fa79ae2808de29980efb88f2e4d616b65207573207368696e65206c696b6520746865206d6f6f6ef09f8c9d2e20492077616e7420746f206372656174652061207374726f6e6720636f6d6d756e69747920616e6420686f706520746f2066696e6420796f75206f6e206f757220736964652e4920686f706520746f206561726e20796f75722074727573742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733458947433.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

