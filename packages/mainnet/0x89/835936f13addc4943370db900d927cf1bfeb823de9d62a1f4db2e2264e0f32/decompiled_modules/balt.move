module 0x89835936f13addc4943370db900d927cf1bfeb823de9d62a1f4db2e2264e0f32::balt {
    struct BALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALT>(arg0, 6, b"BALT", b"SUI BALT CAT", b"Balt is like a roaring wild cat, a true degen, vibing on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_7_9a5f04279c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALT>>(v1);
    }

    // decompiled from Move bytecode v6
}

