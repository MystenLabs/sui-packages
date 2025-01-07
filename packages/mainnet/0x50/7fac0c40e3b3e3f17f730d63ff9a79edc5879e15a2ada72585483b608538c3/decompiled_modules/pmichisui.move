module 0x507fac0c40e3b3e3f17f730d63ff9a79edc5879e15a2ada72585483b608538c3::pmichisui {
    struct PMICHISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMICHISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMICHISUI>(arg0, 6, b"PMICHISUI", b"Patriot Michi SUI", b"Patriot Michi SUI is the brave and bold feline hero of the Sui blockchain, draped in digital stars and stripes! This fearless cat embodies the spirit of freedom and decentralized power, standing tall as a symbol of pride in the ever-expanding world of crypto. Whether defending the blockchain or leading daring trades, Patriot Michi SUI is a true patriot, rallying a community of believers in both cats and crypto revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/perfe_1cc54235a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMICHISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMICHISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

