module 0xe231387e766c34e32e6a578146dc23659c6ee2e63728faf3a8373e00f1d8bd5a::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGG>(arg0, 6, b"EGG", b"Project 0xD38", b"Project 0xD38: DNA modified beyond chicken origins, creating a self-adaptive organism with unpredictable potential. Evolution unbound, the result defies its own protocol. $EGG deployed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/egg1500x1500_375c7ff52d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

