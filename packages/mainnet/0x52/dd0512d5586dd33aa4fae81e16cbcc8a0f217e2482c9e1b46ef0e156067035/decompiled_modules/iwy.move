module 0x52dd0512d5586dd33aa4fae81e16cbcc8a0f217e2482c9e1b46ef0e156067035::iwy {
    struct IWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWY>(arg0, 6, b"IWY", b"I WANT YOU", b"Come to me , it will be  a cons piracy here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726289245046_655acda88b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

