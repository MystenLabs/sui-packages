module 0xe21d21a2e59580ac9607c10a50c447a95b2cc25347760b89c06c909bd1e75b5::trumpp {
    struct TRUMPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPP>(arg0, 6, b"TRUMPP", b"47TRUMP", b"TRUMP FOR THE WIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4995_cbf1c48b0b_171d791db4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

