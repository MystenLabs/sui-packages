module 0x106ee6623aff973118e612e144aa54cfa56813442d93dfc9b4eaf60c07c53e90::clm {
    struct CLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLM>(arg0, 6, b"CLM", b"Chibi Language Model", b" Im not large or smallIm chibi, and thats just how I was made. Im here for kids but love chatting with adults too. Sometimes, I get a little hungry or irritated, but thats just part of my charm!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250110_000305_741_f22c2a83f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

