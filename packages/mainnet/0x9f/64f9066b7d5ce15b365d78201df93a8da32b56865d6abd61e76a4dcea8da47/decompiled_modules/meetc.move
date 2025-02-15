module 0x9f64f9066b7d5ce15b365d78201df93a8da32b56865d6abd61e76a4dcea8da47::meetc {
    struct MEETC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEETC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEETC>(arg0, 9, b"MEETC", b"Meet Cute", b"Sheila, a young woman grappling with suicidal thoughts, discovers that a tanning bed in a nail salon is a time machine. Traveling back 24 hours, she relives the best date night of her life over and over, only to decide that her boyfriend, Gary, needs some fixing. Unaware that meddling with the past could ruin the future, Sheila goes even further back in time to turn him into the perfect man -- even though he was already pretty perfect.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://en.wikipedia.org/wiki/File:Meet_Cute_(film).jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEETC>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEETC>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEETC>>(v1);
    }

    // decompiled from Move bytecode v6
}

