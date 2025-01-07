module 0x3da9e7f4c378c6d66fd24abfceabde187611077af92417848089cc8ebfd19650::huggy {
    struct HUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUGGY>(arg0, 6, b"HUGGY", b"HUGGY On SUI", b"Huggy is blue-furred creature created by the Playtime Company as part of their Bigger Bodies Initiative. Huggy Wuggy is known for his dilated eyes and a mouth full of sharp teeth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000115383_a7ec9ef179.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

