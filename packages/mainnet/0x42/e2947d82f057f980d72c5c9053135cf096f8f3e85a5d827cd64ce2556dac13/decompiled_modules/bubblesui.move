module 0x42e2947d82f057f980d72c5c9053135cf096f8f3e85a5d827cd64ce2556dac13::bubblesui {
    struct BUBBLESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLESUI>(arg0, 6, b"BUBBLESUI", b"Bubbles the Suimmer", b"This will be the cat meme on SUI, mark my words this is it, no cat can take on Bubbles the SUImmer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_34bdc9b228.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

