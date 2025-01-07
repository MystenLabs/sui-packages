module 0x6ae053adfe61d4eaf2a3bbf181c05d053877cec2077abc1150110d958f65a7::mud {
    struct MUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUD>(arg0, 6, b"MUD", b"Mudcrabs", b"You cannot trade any other coin while enemies are nearby. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_c68e333c22.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

