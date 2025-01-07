module 0xe66b9791808c1df3aa2382a05f75330382a5afb425828e76d7f6590eda871196::white {
    struct WHITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHITE>(arg0, 6, b"WHITE", b"The White Meme", b"I got$WHITE, I got $WHITE , what you want ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n9x_F_Ikn_400x400_7d571964c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

