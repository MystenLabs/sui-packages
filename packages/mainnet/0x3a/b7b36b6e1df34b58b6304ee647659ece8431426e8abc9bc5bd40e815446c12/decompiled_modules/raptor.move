module 0x3ab7b36b6e1df34b58b6304ee647659ece8431426e8abc9bc5bd40e815446c12::raptor {
    struct RAPTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAPTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAPTOR>(arg0, 6, b"RAPTOR", b"Sui Raptor", b"ntroducing Sui Raptor (RAPTOR)  the wildest token on the blockchain!  Combining the speed and agility of the raptor with the power of the Sui ecosystem, RAPTOR is here to take over the meme coin scene. Built mainly for fun & growth, this token is a Jurassic-sized opportunity for early adopters and meme lovers alike. Get ready to roar, because RAPTOR is your ticket to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/abcd_f2b577e6d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAPTOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAPTOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

