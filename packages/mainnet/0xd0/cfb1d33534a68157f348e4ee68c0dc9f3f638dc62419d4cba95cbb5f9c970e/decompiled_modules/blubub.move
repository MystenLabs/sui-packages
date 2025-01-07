module 0xd0cfb1d33534a68157f348e4ee68c0dc9f3f638dc62419d4cba95cbb5f9c970e::blubub {
    struct BLUBUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBUB>(arg0, 6, b"Blubub", b"Blublublublub", b"blublublublublublublublublublub (drown on SUI)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_1_ee27662e70.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

