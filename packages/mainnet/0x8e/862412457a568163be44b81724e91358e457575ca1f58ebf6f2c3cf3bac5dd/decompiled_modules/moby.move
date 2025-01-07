module 0x8e862412457a568163be44b81724e91358e457575ca1f58ebf6f2c3cf3bac5dd::moby {
    struct MOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBY>(arg0, 6, b"MOBY", b"MOBY SUI", b"$MOBY THE SUI WHALE. narrative Is very simple. WE are going to prove that Sui chain whales can stay in $moby instead of Other Chains because this Is a safe environment, the community Is a real one and bullish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOBY_27674c93ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

