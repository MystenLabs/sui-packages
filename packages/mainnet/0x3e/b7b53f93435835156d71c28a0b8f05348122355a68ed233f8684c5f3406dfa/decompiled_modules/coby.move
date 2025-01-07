module 0x3eb7b53f93435835156d71c28a0b8f05348122355a68ed233f8684c5f3406dfa::coby {
    struct COBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COBY>(arg0, 6, b"Coby", b"yourfriendcoby", b"Once you're in the cult - $COBY becomes your best friend forever. Join our telegram: https://t.me/coby4sol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/teste_sui_1a73164377.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

