module 0x4418ad48ac224d92124af9cc655ab27a63e371bd96b14dd4ed65e197c5c9c378::stogy {
    struct STOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOGY>(arg0, 6, b"STOGY", b"Stogy The Stoner", b"Stogy The Stoner is not a character it is a lifestyle...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049220_9b87e7b8fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

