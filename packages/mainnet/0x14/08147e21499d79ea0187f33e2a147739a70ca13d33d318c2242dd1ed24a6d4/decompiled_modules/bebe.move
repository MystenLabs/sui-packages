module 0x1408147e21499d79ea0187f33e2a147739a70ca13d33d318c2242dd1ed24a6d4::bebe {
    struct BEBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBE>(arg0, 6, b"BEBE", b"bebe", b"I am a meme artist you can't forget, use memes to entertain myself.  creator. NO FINANCIAL ADVICE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_RG_8_Kl7_400x400_56f4a9cc4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

