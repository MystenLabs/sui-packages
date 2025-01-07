module 0x86731ae97c1c9790cccff43a1abea1c2ae7a6cc34bd8ef2938571f68446ae71::sow {
    struct SOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOW>(arg0, 6, b"SOW", b"SMOKE ON THE WATER", b"Would you ever  imagine a fish smoking on the water? Thats exactly why we are here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3290_PNG_ed9b1dbede.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

