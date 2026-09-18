module 0x6617d7b62af175e18df2d9d629b076d8683e08bb2b7e3c058ba5d8e072a5c74a::suidoodle {
    struct SUIDOODLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOODLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOODLE>(arg0, 6, b"SUIDOODLE", b"Sui Doodle", b" The official mascot of SUI's high-speed network. Drawn with zero skill. Join the army of doodles. High Tech. Low Art. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1789762298148.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOODLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOODLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

