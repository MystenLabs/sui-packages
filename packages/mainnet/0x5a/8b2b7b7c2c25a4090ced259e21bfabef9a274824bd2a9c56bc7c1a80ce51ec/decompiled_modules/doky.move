module 0x5a8b2b7b7c2c25a4090ced259e21bfabef9a274824bd2a9c56bc7c1a80ce51ec::doky {
    struct DOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOKY>(arg0, 6, b"Doky", b"DOKY", b"Doky is a unique memecoin on the Sui network, created to bring boundless joy. Inspired by the quirky internet culture, Doky unites a community seeking entertainment and fun in the crypto world. With a relaxed and playful style, Doky is the choice for those who want to enjoy themselves without strict rules, offering a fresh and different vibe amidst the existing memecoin trends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241105_155233_b27329aa99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

