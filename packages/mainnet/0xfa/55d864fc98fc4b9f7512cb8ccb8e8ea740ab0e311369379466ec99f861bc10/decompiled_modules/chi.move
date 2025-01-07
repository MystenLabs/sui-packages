module 0xfa55d864fc98fc4b9f7512cb8ccb8e8ea740ab0e311369379466ec99f861bc10::chi {
    struct CHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHI>(arg0, 6, b"CHI", b"Chihuahua", b"Join the Chihuahua revolution, the new digital currency that combines fun with the power of meme coins! Invest in this unique coin that blends humor with the potential for quick profits. With a promise to burn 10% of the supply every month for 5 months, scarcity and value growth are guaranteed. Dont miss outbe part of the Chihuahua community today. The bright future starts here!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_207_92d0765763.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

