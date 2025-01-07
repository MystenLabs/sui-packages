module 0x2fcbde0de0b5ea208bf7535329bcbac7f8f9a7523eba36597bf8ec8bc6c99d94::gfish {
    struct GFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFISH>(arg0, 6, b"GFISH", b"Grumpy Fish", b"The $GFISH is the official token of Grumpy Fish, the grumpiest and most cantankerous fish in the sea! With a scowling gaze and a grumpy personality, Grumpy Fish embodies all those days when the market isnt in your favor, but you tackle it with humor and sarcasm. The token swims through the depths of the SUI network, bringing rewards to holders who know how to ride the waves even in the roughest waters. Just like Grumpy Fish, you can be grumpy but always stay a step ahead, keeping calm in turbulent seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_00_40_34_5ea5a8ab0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

