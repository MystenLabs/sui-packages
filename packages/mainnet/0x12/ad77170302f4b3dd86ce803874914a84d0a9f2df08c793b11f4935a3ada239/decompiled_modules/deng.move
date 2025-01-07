module 0x12ad77170302f4b3dd86ce803874914a84d0a9f2df08c793b11f4935a3ada239::deng {
    struct DENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENG>(arg0, 6, b"Deng", b"Moodeng", b"Narrative ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0431_a5b645f7a9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

