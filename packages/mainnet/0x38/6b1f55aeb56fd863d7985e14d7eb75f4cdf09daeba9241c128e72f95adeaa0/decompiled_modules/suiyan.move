module 0x386b1f55aeb56fd863d7985e14d7eb75f4cdf09daeba9241c128e72f95adeaa0::suiyan {
    struct SUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYAN>(arg0, 6, b"SUIYAN", b"Suiyan Cat", b"A safe Team is launching this with a good emphasis on quality memes. Nyan Cat blew up on YouTube in 2011 and now we have the meme ready to make it big with SUI. You can see the amount of work already put into the meme and they have quality content.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_22_23_58_37_05489b56e5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

