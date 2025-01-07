module 0x6cb197f412a127c859a78eb4ef3c6cc8c87ef50c349f9547b00a89ba13e3ce2f::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK>(arg0, 6, b"SHARK", b"Sui Shark", b"SHARK is a fierce memecoin on SUI, always hunting for Jeeters' blood and riding the biggest waves to victory. With its sharp bite, SHARK thrives on action and is speeding straight to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/New_Project_2024_10_07_T234733_441_1b7f40159d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

