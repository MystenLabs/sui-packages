module 0x866d013f6d88a3cdb0c8f7a110c2ea091c5ec394ac2a319a6afece68318d5886::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGG>(arg0, 6, b"EGG", b"EGG coin", b"Egg coin is a stable coin base on eggs . My ultimate goal is 1 egg = 1 real egg . Doesn't matter how long it take , we will be there , trust in the egg revolution , replace the Dollar with Egg coins .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736427772567.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

