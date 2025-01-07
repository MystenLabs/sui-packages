module 0x36a088f24e899843a9ef542c45164baf31855a572b6687639f6ecf140ea0ebf::pookie {
    struct POOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOKIE>(arg0, 6, b"POOKIE", b"Meow Pookie Cat", b"Meet Pookie Cat, the latest sensation living on the Sui blockchain! Pookie Cat is a fun and quirky digital pet, bringing joy to the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_81e5d1f364.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

