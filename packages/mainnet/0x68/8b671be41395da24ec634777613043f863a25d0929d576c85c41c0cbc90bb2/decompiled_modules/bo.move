module 0x688b671be41395da24ec634777613043f863a25d0929d576c85c41c0cbc90bb2::bo {
    struct BO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BO>(arg0, 6, b"BO", b"BO THE OCTOPUS   ( BO  )", b"I'm the most cute octopus, making waves in the SUI ocean. Help me grow up and we'll catch whales.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/caracatita_pe_val_47d61b26f5.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BO>>(v1);
    }

    // decompiled from Move bytecode v6
}

