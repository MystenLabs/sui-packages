module 0xde007a3dd6a20e66a91d1dc83ed8743dff1c8dd3e89714dc7a82106f65370e79::shqrl {
    struct SHQRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHQRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHQRL>(arg0, 6, b"SHQRL", b"Shquirl", b"Behold the $SHQRL, the fiercest predator in the oceans! But hes here to make friends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_83ba007aaf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHQRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHQRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

