module 0x73fef1db1e3cfbc7ed3b7f46236f31565cd74926535461d9efeccfb116506acf::trumpeter {
    struct TRUMPETER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPETER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPETER>(arg0, 6, b"TRUMPETER", b"Trumpeter", b"The first angel blew his trumpet, and there followed hail and fire, mixed with blood, and these were thrown upon the earth. And a third of the earth was burned up, and a third of the trees were burned up, and all green grass was burned up.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3460_bc89660bf8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPETER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPETER>>(v1);
    }

    // decompiled from Move bytecode v6
}

