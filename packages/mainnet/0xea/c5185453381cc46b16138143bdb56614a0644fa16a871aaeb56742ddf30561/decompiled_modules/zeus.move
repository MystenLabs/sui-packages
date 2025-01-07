module 0xeac5185453381cc46b16138143bdb56614a0644fa16a871aaeb56742ddf30561::zeus {
    struct ZEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEUS>(arg0, 6, b"ZEUS", b"ZEUS on SUI", x"4761746865722061726f756e6420616e64206c65742075732074656c6c20796f75207468652074616c65206f66205a6575732c20746865206f6e6520616e64206f6e6c7920646f67206f6620746865206c6567656e646172792050657065210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_Z_E_Lfp_400x400_23fd861d28.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

