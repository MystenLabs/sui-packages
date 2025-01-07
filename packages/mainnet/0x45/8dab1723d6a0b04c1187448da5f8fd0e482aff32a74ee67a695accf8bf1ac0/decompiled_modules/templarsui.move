module 0x458dab1723d6a0b04c1187448da5f8fd0e482aff32a74ee67a695accf8bf1ac0::templarsui {
    struct TEMPLARSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLARSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLARSUI>(arg0, 6, b"Templarsui", b"Order of the Ancients", b"May the father of understanding guide us to blue dex/raydium.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/templar_image_6dfcbad8ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLARSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMPLARSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

