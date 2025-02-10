module 0x25ad8bb42440e27276739f81f3efdc37387b7bce7f063af74fdf905900c41008::kirk {
    struct KIRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRK>(arg0, 9, b"Kirk", b"StarTrekKirkcoin", b"In a galaxy far, far away, Captain James T. Kirk accidentally discovered a mysterious energy source while engaging in a game of holodeck poker. Believing it to be a new form of Klingon ale, he and his crew consumed it, instantly turning them into the greatest poker players in the universe. They named this newfound energy 'Kirkcoin' and started using it to fund their intergalactic adventures, becoming the wealthiest and most famous crew in the Federation. The token represents the power of luck and strategy in the cosmos, and its value fluctuates based on the outcome of interstellar poker tournaments and the success of their latest mission.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739209381/qsdqbhcugyk6upsskd4v.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIRK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

