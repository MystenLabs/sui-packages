module 0xd74100666c8d0e0321d3dee7f8f44188f16bd936aa90ee1e630f7cf183ffcff5::bomeow {
    struct BOMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMEOW>(arg0, 6, b"BOMEOW", b"Book of Meow", b"Introducing the Book of Meow ($BOMEOW), a Sui meme token that is the purr-fect variation of different mews across the entire meow-niverse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_TO_Bn_Bms_400x400_4edc7dcf07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

