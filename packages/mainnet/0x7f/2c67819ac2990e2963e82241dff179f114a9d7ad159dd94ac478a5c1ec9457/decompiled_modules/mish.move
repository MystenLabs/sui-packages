module 0x7f2c67819ac2990e2963e82241dff179f114a9d7ad159dd94ac478a5c1ec9457::mish {
    struct MISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISH>(arg0, 6, b"Mish", b"Mish the fish", b"A fish known for having a cleft lip is the mish, specifically the Mish fish or Cleft-lip Catfish (scientific name: Glyptothorax spp.). This fish is often found in freshwater habitats in South Asia and is characterized by its distinctively split or cleft-like mouth, which aids in feeding.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FB_IMG_1720229990433_4cfd119158.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

