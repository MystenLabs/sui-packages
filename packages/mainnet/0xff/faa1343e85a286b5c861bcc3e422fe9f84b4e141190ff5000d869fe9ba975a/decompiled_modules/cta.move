module 0xfffaa1343e85a286b5c861bcc3e422fe9f84b4e141190ff5000d869fe9ba975a::cta {
    struct CTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTA>(arg0, 6, b"CTA", b"CAT THEFT AUTO", b"We got CTA before GTA6 .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735738341889.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

