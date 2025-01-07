module 0xd458ecd5dee00397fe40f13d24b648471ecae1c1825fe0614176586a88a9be40::anubis {
    struct ANUBIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANUBIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANUBIS>(arg0, 6, b"ANUBIS", b"ANUBIS DOG", b"anubis the king of sui dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8efc60f6_f7d5_4c3e_987f_5b0ad41258f4_b1efa85465.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANUBIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANUBIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

