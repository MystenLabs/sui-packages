module 0x41948a75ca7ced17d4b2002ae401e74868b09280c934249c5d2da1607da269e::scf {
    struct SCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCF>(arg0, 6, b"SCF", b"Smoking Chicken Fish", b"Born from the twisted depths of crypto hell, the Smoking Chicken Fish is the patron saint of unfiltered insanity. This nicotine-addicted freak doesnt give a rats ass about your rules or your reality. Its a fish, its a chicken, its a chain-smoking enigma flipping the bird to the universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_893b54c6f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

