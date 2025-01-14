module 0x78f9562b6be9904a6e01cbe6315cd4500e0111e6731b822db72918275fc28de5::dgtrmp {
    struct DGTRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGTRMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGTRMP>(arg0, 6, b"DGTRMP", b"DogTrump", b"Big barks, bold moves, and meme greatness. Making the doghouse great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ee_9c4caa8857.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGTRMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGTRMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

