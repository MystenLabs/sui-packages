module 0x6d178710d11cca55d72ada07c3d0ffd7b082744bc610e2023e21e0f07dd8054::what {
    struct WHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHAT>(arg0, 9, b"WHAT", b"What you wanna do?", b"Just do it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/kboZwrn.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHAT>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHAT>>(v2, @0x96d9a120058197fce04afcffa264f2f46747881ba78a91beb38f103c60e315ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

