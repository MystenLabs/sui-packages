module 0x7bcbd9320bd8bce281aaabbdf256145f3bc787d2ae836cadf5e589e4fac9a577::pepechan {
    struct PEPECHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPECHAN>(arg0, 6, b"PEPECHAN", b"Pepe Chan", b"Get ready to dive into the whimsical world of Pepe Chan, where cuteness meets cryptocurrency! Our delightful little amphibian is not just another token; he's the ultimate ticket to a playful community bursting with potential. But hold onto your hats, fam, because weve got some wild milestones lined up thatll make your heart race faster than a frog hopping across a lily pad!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_5_2fc8c8fa8c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPECHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

