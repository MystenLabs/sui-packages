module 0xeef2a918118bb69eb0ddff7aede1c2f6be5ccac51744aa65c30fb01dccd66425::blak {
    struct BLAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAK>(arg0, 6, b"BLAK", b"Blak Trump", x"594f5552204641564f52495445204c4547454e442e2e3f0a50524f4241424c592e2e2e20424c414b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029601_39ea955bdc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

