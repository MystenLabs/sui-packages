module 0xfb69f47717356a732c15109880dd711edc746aef9f745320434029416b72447f::scye {
    struct SCYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCYE>(arg0, 6, b"SCYE", b"Suicoinye", b"Suicoinye is a digital coin inspired by the unreleased Kanye West cryptocurrency. It pays homage to the original concept, blending Kanye's iconic image with modern blockchain aesthetics, creating a coin that merges culture with crypto innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3722_3cb512bf61.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

