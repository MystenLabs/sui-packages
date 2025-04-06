module 0x1ab6914ac20df48d8a78a11cfbaf4e3ff830ca204223571ee9656cb29f7e04b2::fluix {
    struct FLUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUIX>(arg0, 9, b"FLUIX", b" Fluix", b"Fluix is a next-generation digital asset built on the Sui blockchain, designed to power fast, fluid, and scalable decentralized applications. With its sleek design and seamless integration, Fluix embodies motion, adaptability, and innovation. Whether you're building, trading, or exploring the future of Web3, Fluix keeps you in the flow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f908c3789bb760a0013d8831b44d5436blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLUIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

