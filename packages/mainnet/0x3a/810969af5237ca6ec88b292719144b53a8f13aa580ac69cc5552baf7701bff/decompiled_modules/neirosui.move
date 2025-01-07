module 0x3a810969af5237ca6ec88b292719144b53a8f13aa580ac69cc5552baf7701bff::neirosui {
    struct NEIROSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIROSUI>(arg0, 6, b"NeiroSui", b"Baby Neiro on Sui", b"Baby Neiro is a meme coin inspired by a Shiba Inu dog named Neiro. It's built on the Sui blockchain and is part of the growing meme coin ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7051_6e86d9531f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIROSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIROSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

